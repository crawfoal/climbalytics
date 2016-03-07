class GymPickersController < ApplicationController
  def show
    render partial: 'shared/gym_picker'
  end
end
