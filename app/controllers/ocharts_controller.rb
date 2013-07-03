class OchartsController < ApplicationController
  before_action :set_ochart, only: [:show, :edit, :update, :destroy]

  # GET /ocharts
  # GET /ocharts.json
  def index
    @ocharts = Ochart.all
  end

  # GET /ocharts/1
  # GET /ocharts/1.json
  def show
  end

  # GET /ocharts/new
  def new
    @ochart = Ochart.new
  end

  # GET /ocharts/1/edit
  def edit
  end

  # POST /ocharts
  # POST /ocharts.json
  def create
    @ochart = Ochart.new(ochart_params)

    respond_to do |format|
      if @ochart.save
        format.html { redirect_to @ochart, notice: 'Ochart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ochart }
      else
        format.html { render action: 'new' }
        format.json { render json: @ochart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ocharts/1
  # PATCH/PUT /ocharts/1.json
  def update
    respond_to do |format|
      if @ochart.update(ochart_params)
        format.html { redirect_to @ochart, notice: 'Ochart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ochart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ocharts/1
  # DELETE /ocharts/1.json
  def destroy
    @ochart.destroy
    respond_to do |format|
      format.html { redirect_to ocharts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ochart
      @ochart = Ochart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ochart_params
      params.require(:ochart).permit(:ochart_id, :department_name, :parent_id, :comp_id)
    end
end
