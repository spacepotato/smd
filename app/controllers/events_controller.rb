class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index] 
  helper_method :is_club_current_admin?

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @is_club_admin = is_club_admin?
  end

  # GET /events/1
  # GET /events/1.json
  def show
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

    respond_to do |format|
      if @event.save
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
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :location, :event_date, :start_time, :description, :ticket_info, :num_of_tickets, :ticket_price, :image, :image2, :image3)
    end
end
