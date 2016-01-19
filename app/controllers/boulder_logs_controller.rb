class BoulderLogsController < ApplicationController
  before_action :set_boulder_log, only: [:show, :edit, :update, :destroy]

  # GET /boulder_logs
  # GET /boulder_logs.json
  def index
    @boulder_logs = BoulderLog.all
  end

  # GET /boulder_logs/1
  # GET /boulder_logs/1.json
  def show
    authorize @boulder_log
  end

  # GET /boulder_logs/new
  def new
    authorize BoulderLog
    @boulder_log = BoulderLog.new
  end

  # GET /boulder_logs/1/edit
  def edit
    authorize @boulder_log
  end

  # POST /boulder_logs
  # POST /boulder_logs.json
  def create
    authorize BoulderLog, :new?
    @boulder_log = current_user.athlete_story.boulder_logs.build(boulder_log_params)
    authorize @boulder_log
    respond_to do |format|
      if @boulder_log.save
        format.html { redirect_to @boulder_log, notice: 'Boulder log was successfully created.' }
        format.json { render :show, status: :created, location: @boulder_log }
      else
        format.html { render :new }
        format.json { render json: @boulder_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boulder_logs/1
  # PATCH/PUT /boulder_logs/1.json
  def update
    authorize @boulder_log
    respond_to do |format|
      if @boulder_log.update(boulder_log_params)
        format.html { redirect_to @boulder_log, notice: 'Boulder log was successfully updated.' }
        format.json { render :show, status: :ok, location: @boulder_log }
      else
        format.html { render :edit }
        format.json { render json: @boulder_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boulder_logs/1
  # DELETE /boulder_logs/1.json
  def destroy
    authorize @boulder_log
    @boulder_log.destroy
    respond_to do |format|
      format.html { redirect_to boulder_logs_url, notice: 'Boulder log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boulder_log
      @boulder_log = BoulderLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boulder_log_params
      params.require(:boulder_log).permit(:grade, :quality_rating, :note, :project, :athlete_story_id, :boulder_id)
    end
end
