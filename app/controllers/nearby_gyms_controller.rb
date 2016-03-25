class NearbyGymsController < ApplicationController
  def show
    render partial: 'athlete_dashboards/nearby_gyms'
  end
end
