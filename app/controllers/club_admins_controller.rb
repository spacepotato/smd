class ClubAdminsController < ApplicationController
  before_action :set_club_admin, only: [:show, :edit, :update, :destroy]

  # GET /club_admins
  # GET /club_admins.json
  def index
    @club_admins = ClubAdmin.all
  end

  # GET /club_admins/1
  # GET /club_admins/1.json
  def show
  end

  # GET /club_admins/new
  def new
    @club_admin = ClubAdmin.new
  end

  # GET /club_admins/1/edit
  def edit
  end

  # POST /club_admins
  # POST /club_admins.json
  def create
    @club_admin = ClubAdmin.new(club_admin_params)

    respond_to do |format|
      if @club_admin.save
        format.html { redirect_to @club_admin, notice: 'Club admin was successfully created.' }
        format.json { render :show, status: :created, location: @club_admin }
      else
        format.html { render :new }
        format.json { render json: @club_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_admins/1
  # PATCH/PUT /club_admins/1.json
  def update
    respond_to do |format|
      if @club_admin.update(club_admin_params)
        format.html { redirect_to @club_admin, notice: 'Club admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @club_admin }
      else
        format.html { render :edit }
        format.json { render json: @club_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_admins/1
  # DELETE /club_admins/1.json
  def destroy
    @club_admin.destroy
    respond_to do |format|
      format.html { redirect_to club_admins_url, notice: 'Club admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_admin
      @club_admin = ClubAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_admin_params
      params[:club_admin]
    end
end
