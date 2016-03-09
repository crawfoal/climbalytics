class RoutePickersController < ApplicationController
  def show
    @gym = Gym.find(params[:id])
    render partial: 'athlete_dashboards/route_picker'
  end

  protected
  def gym_id
    params.require(:id)
  end
end
