class AthleteClimbLogsController < ApplicationController
  before_action :set_athlete_climb_log, only: [:edit, :update]

  # GET /athlete_climb_logs/new
  # POST /athlete_climb_log/new
  def new
    authorize AthleteClimbLog
    @athlete_climb_log = AthleteClimbLog.new(params_for_new)
    @athlete_climb_log.build_climb unless @athlete_climb_log.climb.present?
  end

  # GET /athlete_climb_logs/1/edit
  def edit
    authorize @athlete_climb_log
  end

  # POST /athlete_climb_logs
  def create
    authorize AthleteClimbLog, :new?
    @athlete_climb_log = current_user.athlete_story.athlete_climb_logs.build(athlete_climb_log_params)
    authorize @athlete_climb_log
    if @athlete_climb_log.save
      redirect_to root_path, notice: 'Athlete climb log was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /athlete_climb_logs/1
  def update
    authorize @athlete_climb_log
    if @athlete_climb_log.update(athlete_climb_log_params)
      redirect_to root_path, notice: 'Athlete climb log was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete_climb_log
      @athlete_climb_log = AthleteClimbLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def athlete_climb_log_params
      params.require(:athlete_climb_log).permit(
        :quality_rating,
        :note,
        :project,
        :athlete_story_id,
        :setter_climb_log_id,
        {climb_attributes: [
          :id,
          :name,
          :moves_count,
          :type,
          :grade,
          :gym_section_id
        ]},
        {climb_seshes_attributes: [
          :id,
          :high_hold,
          :note,
          :_destroy
        ]}
      )
    end

    def presets_given?
      params.has_key? :athlete_climb_log
    end

    def slog_specified?
      athlete_climb_log_params[:setter_climb_log_id].present?
    end

    def presets_from_slog
      slog = SetterClimbLog.find(athlete_climb_log_params[:setter_climb_log_id])

      {setter_climb_log_id: athlete_climb_log_params[:setter_climb_log_id], climb_attributes: slog.climb.value_attributes}
    end

    def params_for_new
      return nil unless presets_given?

      if slog_specified?
        presets_from_slog
      else
        athlete_climb_log_params
      end
    end
end
