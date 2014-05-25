class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index] 
  helper_method :is_club_current_admin?, :follow_event, :is_following?, :unfollow_event, :is_club_admin?

  # GET /events
  # GET /events.json
  def index
    @events = Event.all


    if user_signed_in?
      @is_club_admin = is_club_admin?
    else
      @is_club_admin = false
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @comment = Comment.new
    @followers = Array.new
    
    EventFollows.all.each do |temp_follow|
      if temp_follow.event_id == params[:id].to_i
        @followers.push(temp_follow.user)
      end
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    @belonging_clubs = Array.new

    ClubAdmin.all.each do |temp_admin|
      if temp_admin.user_id == current_user.id
        @belonging_clubs.push(Club.find(temp_admin.club_id))
      end
    end

  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.parent_club = Club.find(params[:parent_club]).name


    @club_event = ClubEvents.new({:event => @event})
    @club_event.club_id = params[:parent_club]

    respond_to do |format|
      if @event.save && @club_event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    club_id = get_club_id(@event)

    if is_club_current_admin?(club_id)

      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = "You cannot delete an event unless you are the club admin"
      redirect_to :back
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

  def get_club_id(event)
    club_event =  ClubEvents.where(:event_id => event.id).first

    if !club_event.blank?
      logger.info "Club id found"
      return club_event.club_id
    else
      logger.info "Club id not found"
      return 100
    end
    
  end

  def is_club_current_admin?(club_id)
    if !ClubAdmin.where(:user_id => current_user.id, :club_id => club_id).blank?
      return true
    else
      return false
    end
  end

  #Creating an entry in the Event follows table to indicate that the current user is following the current event
  def follow_event
    @follow = EventFollows.new(:user_id => current_user.id, :event_id => params[:id] )
    respond_to do |format|
      if @follow.save
        format.html { redirect_to Event.find(params[:id]), notice: 'You have successfully followed this event' }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end

  end

  #It doesn't make sense to display a follow button if the user is already following the event, so we need a way
  #To check if the current is following the current event
  def is_following?(event_id)
    EventFollows.all.each do |temp_follow|
      if temp_follow.user_id == current_user.id && temp_follow.event_id == event_id
        return true
      end
    end
    return false
  end

  #Making it so the user can unfollow an event
  def unfollow_event
    @follow = EventFollows.where(:user_id=>current_user.id).where(:event_id=> params[:id]).first
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to Event.find(params[:id]), notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  def reserve_ticket

    @quantity = params[:quantity].to_i
    @event = Event.find(params[:id])

    for x in (1..@quantity) 
      temp_ticket = Ticket.new
      temp_ticket.event_id = @event.id
      temp_ticket.user_id = current_user.id
      temp_ticket.save
    end

    if @quantity <= @event.num_of_tickets
      @event.num_of_tickets = @event.num_of_tickets - @quantity
      flash[:success] = "Tickets reserved successfully"
      @event.save
    else
      flash[:error] = "Not Enought Tickets for Requested Reservation"
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :location, :event_date, :start_time, :description, :ticket_info, :num_of_tickets, :ticket_price, :banner, :image, :image2, :image3, :parent_club, :quantity, :report)
    end
  end
