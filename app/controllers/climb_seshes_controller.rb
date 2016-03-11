class ClimbSeshesController < ApplicationController
  before_action :set_climb_sesh, only: [:show, :edit, :update, :destroy]

  # GET /climb_seshes/new
  def new
    @climb_sesh = ClimbSesh.new
  end

  # GET /climb_seshes/1/edit
  def edit
  end

  # POST /climb_seshes
  # POST /climb_seshes.json
  def create
    @climb_sesh = ClimbSesh.new(climb_sesh_params)

    respond_to do |format|
      if @climb_sesh.save
        format.html { redirect_to @climb_sesh, notice: 'Climb sesh was successfully created.' }
        format.json { render :show, status: :created, location: @climb_sesh }
      else
        format.html { render :new }
        format.json { render json: @climb_sesh.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /climb_seshes/1
  # PATCH/PUT /climb_seshes/1.json
  def update
    respond_to do |format|
      if @climb_sesh.update(climb_sesh_params)
        format.html { redirect_to @climb_sesh, notice: 'Climb sesh was successfully updated.' }
        format.json { render :show, status: :ok, location: @climb_sesh }
      else
        format.html { render :edit }
        format.json { render json: @climb_sesh.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /climb_seshes/1
  # DELETE /climb_seshes/1.json
  def destroy
    @climb_sesh.destroy
    respond_to do |format|
      format.html { redirect_to climb_seshes_url, notice: 'Climb sesh was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb_sesh
      @climb_sesh = ClimbSesh.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def climb_sesh_params
      params.require(:climb_sesh).permit(:high_hold, :note, :athlete_climb_log_id)
    end
end
