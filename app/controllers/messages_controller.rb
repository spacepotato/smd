class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages_received = current_user.messages
    @messages_sent = Array.new

    Message.all.each do |message|
      if message.sender == current_user.username
        @messages_sent.push(message)
      end
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @user = User.find_by username: @message.recipient


    respond_to do |format|
      #If we are trying to send a message to a user that doesn't exist we want to let the User know that this is just not on
      if @user.blank?
        flash[:error] = "Error"
        format.html { redirect_to :back}
        format.json { render :show, status: :created, location: @message}
      else
        @message.user_id = @user.id

        if @message.save
          flash[:success] = "Your message has been created"
          format.html { redirect_to :back}
          format.json { render :show, status: :created, location: @message}
        else
          format.html { render :new }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params

      params.require(:message).permit(:user_id, :body, :sender_id, :sender, :recipient)

    end

  end
