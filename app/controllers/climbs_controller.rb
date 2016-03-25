class ClimbsController < ApplicationController
  def index
    @climbs = Climb.search(search_params)
    render partial: 'index', locals: {climbs: @climbs}
  end

  protected
  def search_params
    params.permit(:in_section, :in_gym, :with_type)
  end
end
