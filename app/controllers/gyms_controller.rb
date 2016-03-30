class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]

  # GET /gyms
  def index
    @gyms = Gym.all
  end

  # GET /gyms/1
  def show
  end

  # GET /gyms/new
  def new
    @gym = Gym.new
    @gym.build_location.build_address
    @gym.gym_sections.build
  end

  # GET /gyms/1/edit
  def edit
  end

  # POST /gyms
  def create
    @gym = Gym.new(gym_params)
    if @gym.save
      redirect_to @gym, notice: 'Gym was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /gyms/1
  def update
    if @gym.update(gym_params)
      redirect_to @gym, notice: 'Gym was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_gym
      @gym = Gym.find(params[:id])
    end

    def gym_params
      params.require(:gym).permit(
        :name,
        :topo,
        location_attributes: [
          :id,
          address_attributes: [
            :id,
            :line1,
            :line2,
            :city,
            :state_id,
            :zip
          ]
        ],
        gym_sections_attributes: [
          :id,
          :name,
          :_destroy
        ]
      )
    end
end
