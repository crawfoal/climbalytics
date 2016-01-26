class SetterClimbLogsController < ApplicationController
  before_action :set_setter_climb_log, only: [:show, :edit, :update, :destroy]

  # GET /setter_climb_logs
  # GET /setter_climb_logs.json
  def index
    @setter_climb_logs = SetterClimbLog.all
  end

  # GET /setter_climb_logs/1
  # GET /setter_climb_logs/1.json
  def show
  end

  # GET /setter_climb_logs/new
  def new
    authorize SetterClimbLog
    @setter_climb_log = SetterClimbLog.new
  end

  # GET /setter_climb_logs/1/edit
  def edit
    authorize @setter_climb_log
  end

  # POST /setter_climb_logs
  # POST /setter_climb_logs.json
  def create
    authorize SetterClimbLog, :new?
    @setter_climb_log = current_user.setter_story.setter_climb_logs.build(setter_climb_log_params)
    authorize @setter_climb_log
    respond_to do |format|
      if @setter_climb_log.save
        format.html { redirect_to @setter_climb_log, notice: 'SetterClimbLog was successfully created.' }
        format.json { render :show, status: :created, location: @setter_climb_log }
      else
        format.html { render :new }
        format.json { render json: @setter_climb_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /setter_climb_logs/1
  # PATCH/PUT /setter_climb_logs/1.json
  def update
    authorize @setter_climb_log
    respond_to do |format|
      if @setter_climb_log.update(setter_climb_log_params)
        format.html { redirect_to @setter_climb_log, notice: 'SetterClimbLog was successfully updated.' }
        format.json { render :show, status: :ok, location: @setter_climb_log }
      else
        format.html { render :edit }
        format.json { render json: @setter_climb_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setter_climb_logs/1
  # DELETE /setter_climb_logs/1.json
  def destroy
    authorize @setter_climb_log
    @setter_climb_log.destroy
    respond_to do |format|
      format.html { redirect_to setter_climb_logs_url, notice: 'SetterClimbLog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setter_climb_log
      @setter_climb_log = SetterClimbLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setter_climb_log_params
      params.require(:setter_climb_log).permit(:picture, :note)
    end
end
