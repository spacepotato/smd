class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index] 
  helper_method :is_club_current_admin?

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all
    if user_signed_in?
      @is_club_admin = is_club_admin?
    else
      @is_club_admin = false
    end
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    @new_admin = ClubAdmin.new
    @club_admin = Array.new
    ClubAdmin.all.each do |temp_admin|
      if temp_admin.club_id == @club.id
        @club_admin.push(temp_admin)
      end
    
    end    

    @club_event = Array.new

    Event.all.each do |temp_event|
      if temp_event.parent_club == @club.name.to_s
        @club_event.push(temp_event)
      end 
    end
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit
    if is_club_current_admin?(@club.id)
    else
      flash[:error] = "You do not have permission to edit this club"
      redirect_to club_path
    end
  end

  def add_admin
    @username = params[:username]
    @new_admin = ClubAdmin.new
    @new_admin.club_id = params[:id].to_i
    
    if !user_exist?(@username)
      flash[:error] = "User does not exist"
      redirect_to club_path
      return
    else
        @new_admin.user_id = User.find_by(username: @username).id
        @new_admin.position = params[:position]
        @new_admin.phone = params[:phone]

        respond_to do |format|
          #If we are trying to send a message to a user that doesn't exist we want to let the User know that this is just not on
            if @new_admin.save
              flash[:success] = "Your admin has been created"
              format.html { redirect_to :back}
              format.json { render :show, status: :created, location: @message}
            else
              format.html { render :new }
              format.json { render json: @message.errors, status: :unprocessable_entity }
            end
          end
      end
    end


  def user_exist?(username)
    User.all.each do |temp_user|
      if temp_user.username == username
        return true

      end
    end
    return false
  end

  def remove_admin

    if is_club_current_admin?(params[:club_id].to_i)
      if ClubAdmin.where(:club_id => params[:club_id].to_i).length <= 1
        flash[:error] = "error: cannot remove last admin"
        redirect_to :back
        return
      else
        @club_admin = ClubAdmin.where(:user_id=>params[:user_id].to_i , :club_id => params[:club_id].to_i).first
        
        flash[:success] = "Success: impeached admin #{@club_admin.position}"
        @club_admin.destroy
        redirect_to :back
      end
    end

      # respond_to do |params|
      #   ClubAdmin.all.each do |temp_admin|
      #     if (temp_admin.user.id == club_admin.user_id => params[:user_id] )
      #       if (temp_admin.club.id == params[:club_id]) 
      #         temp_admin.destroy
      #       end
      #     end
      #   end
      # end
  end
  
  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(club_params)
    if !validate_club(@club.name)
      flash[:error] = "This is not a registered club"
      redirect_to :back
      return
    elsif does_club_exist?(@club.name)
        flash[:error] = "This is club already exists"
        redirect_to :back
        return
    else
    @club_admin = ClubAdmin.new({:user => current_user,:club => @club, :position => "El Presidente"})
    # @club_admin.club_id = @club.id
    # @club_admin.user_id = current_user.id
    # @club_admin.position = "El Presidente"

    notify_admins(@club.name)


    respond_to do |format|
      if @club.save && @club_admin.save
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render :show, status: :created, location: @club }
      else
        format.html { render :new }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  return
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { render :show, status: :ok, location: @club }
      else
        format.html { render :edit }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    if is_club_current_admin?(@club.id)
    @club.destroy
    respond_to do |format|
      format.html { redirect_to clubs_url, notice: 'Club was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
else
  flash[:error] = "You cannot delete a club you did not create"
  end

  def is_club_admin?
    ClubAdmin.all.each do |temp_entry|
      if temp_entry.user_id == current_user.id
        return true
      end
    end
    return false
  end

  def does_club_exist?(club_name)
    Club.all.each do |temp_club|
      if temp_club.name == club_name
        return true
      end
    end
    return false
  end

  def is_club_current_admin?(club_id)
    ClubAdmin.all.each do |temp_entry|
      if temp_entry.user_id == current_user.id && temp_entry.club_id == club_id
        return true
      end
    end
    return false
  end

  def notify_admins(club_name)

    received = Array.new

    ClubAdmin.all.each do |temp_admin|
      if received.include? temp_admin.user_id
        next
      end

      if temp_admin.user_id != current_user.id
        @temp_message = Message.new
        @temp_message.user_id = temp_admin.user_id
        @temp_message.sender = "ClubBiz"
        @temp_message.recipient = User.find(temp_admin.user_id).username
        @temp_message.body = "The club #{club_name} has just been created"
        @temp_message.save

        #Because we don't want a user to recieve multiple messages if they are the admin of multiple clubs
        received.push(temp_admin.user_id)
      end
    end
  end

  def validate_club(club_name)
    
    if File.open('app/assets/umsu clubs.txt').lines.any?{|line| line.include?(club_name)}
      return true
    end

    return false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.require(:club).permit(:name, :webLink, :registrationNumber, :description, :banner, :image, :image2, :image3)
    end

    def admin_params
      params.require(:club_admin).permit(:club_id, :user_id, :position, :phone)
    end 
  end
