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

  end

  def remove_admin

  end
  
  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(club_params)
    if !validate_club(@club.name)
      flash[:error] = "This is not a registered club"

    else
    @club_admin = ClubAdmin.new({:user => current_user,:club => @club, :position => "El Presidente"})
    # @club_admin.club_id = @club.id
    # @club_admin.user_id = current_user.id
    # @club_admin.position = "El Presidente"
    @club_admin.save

    notify_admins(@club.name)


    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render :show, status: :created, location: @club }
      else
        format.html { render :new }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end
  redirect_to :back
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
    @club.destroy
    respond_to do |format|
      format.html { redirect_to clubs_url, notice: 'Club was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def is_club_admin?
    ClubAdmin.all.each do |temp_entry|
      if temp_entry.user_id == current_user.id
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
      puts "FOUND THE CLUB IN THE FILE!"
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
      params.require(:club).permit(:name, :webLink, :registrationNumber, :description)
    end
  end
