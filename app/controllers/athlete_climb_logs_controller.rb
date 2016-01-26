class AthleteClimbLogsController < ApplicationController
  before_action :set_athlete_climb_log, only: [:show, :edit, :update, :destroy]

  # GET /athlete_climb_logs
  # GET /athlete_climb_logs.json
  def index
    @athlete_climb_logs = AthleteClimbLog.all
  end

  # GET /athlete_climb_logs/1
  # GET /athlete_climb_logs/1.json
  def show
    authorize @athlete_climb_log
  end

  # GET /athlete_climb_logs/new
  def new
    authorize AthleteClimbLog
    @athlete_climb_log = AthleteClimbLog.new
  end

  # GET /athlete_climb_logs/1/edit
  def edit
    authorize @athlete_climb_log
  end

  # POST /athlete_climb_logs
  # POST /athlete_climb_logs.json
  def create
    authorize AthleteClimbLog, :new?
    @athlete_climb_log = current_user.athlete_story.athlete_climb_logs.build(athlete_climb_log_params)
    authorize @athlete_climb_log
    respond_to do |format|
      if @athlete_climb_log.save
        format.html { redirect_to @athlete_climb_log, notice: 'Athlete climb log was successfully created.' }
        format.json { render :show, status: :created, location: @athlete_climb_log }
      else
        format.html { render :new }
        format.json { render json: @athlete_climb_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /athlete_climb_logs/1
  # PATCH/PUT /athlete_climb_logs/1.json
  def update
    authorize @athlete_climb_log
    respond_to do |format|
      if @athlete_climb_log.update(athlete_climb_log_params)
        format.html { redirect_to @athlete_climb_log, notice: 'Athlete climb log was successfully updated.' }
        format.json { render :show, status: :ok, location: @athlete_climb_log }
      else
        format.html { render :edit }
        format.json { render json: @athlete_climb_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athlete_climb_logs/1
  # DELETE /athlete_climb_logs/1.json
  def destroy
    authorize @athlete_climb_log
    @athlete_climb_log.destroy
    respond_to do |format|
      format.html { redirect_to athlete_climb_logs_url, notice: 'Athlete climb log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete_climb_log
      @athlete_climb_log = AthleteClimbLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def athlete_climb_log_params
      params.require(:athlete_climb_log).permit(:quality_rating, :note, :project, :athlete_story_id, :setter_climb_log_id)
    end
end