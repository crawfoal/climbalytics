class BouldersController < ApplicationController
  before_action :set_boulder, only: [:show, :edit, :update, :destroy]

  # GET /boulders
  # GET /boulders.json
  def index
    @boulders = Boulder.all
  end

  # GET /boulders/1
  # GET /boulders/1.json
  def show
  end

  # GET /boulders/new
  def new
    authorize Boulder
    @boulder = Boulder.new
  end

  # GET /boulders/1/edit
  def edit
    authorize @boulder
  end

  # POST /boulders
  # POST /boulders.json
  def create
    authorize Boulder, :new?
    @boulder = current_user.setter_story.boulders.build(boulder_params)
    authorize @boulder
    respond_to do |format|
      if @boulder.save
        format.html { redirect_to @boulder, notice: 'Boulder was successfully created.' }
        format.json { render :show, status: :created, location: @boulder }
      else
        format.html { render :new }
        format.json { render json: @boulder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boulders/1
  # PATCH/PUT /boulders/1.json
  def update
    authorize @boulder
    respond_to do |format|
      if @boulder.update(boulder_params)
        format.html { redirect_to @boulder, notice: 'Boulder was successfully updated.' }
        format.json { render :show, status: :ok, location: @boulder }
      else
        format.html { render :edit }
        format.json { render json: @boulder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boulders/1
  # DELETE /boulders/1.json
  def destroy
    authorize @boulder
    @boulder.destroy
    respond_to do |format|
      format.html { redirect_to boulders_url, notice: 'Boulder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boulder
      @boulder = Boulder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boulder_params
      params.require(:boulder).permit(:name, :grade, :picture)
    end
end
