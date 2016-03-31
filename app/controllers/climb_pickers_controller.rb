class ClimbPickersController < ApplicationController
  def show
    @gym = Gym.find(params[:id])
    render partial: 'athlete_dashboards/climb_picker'
  end

  protected
  def gym_id
    params.require(:id)
  end
end
