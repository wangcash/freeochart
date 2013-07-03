class CompsController < ApplicationController
  before_action :set_comp, only: [:show, :edit, :update, :destroy]

  # GET /comps
  # GET /comps.json
  def index
    @comps = Comp.all
  end

  # GET /comps/1
  # GET /comps/1.json
  def show
  end

  # GET /comps/new
  def new
    @comp = Comp.new
  end

  # GET /comps/1/edit
  def edit
  end

  # POST /comps
  # POST /comps.json
  def create
    @comp = Comp.new(comp_params)

    respond_to do |format|
      if @comp.save
        format.html { redirect_to @comp, notice: 'Comp was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comp }
      else
        format.html { render action: 'new' }
        format.json { render json: @comp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comps/1
  # PATCH/PUT /comps/1.json
  def update
    respond_to do |format|
      if @comp.update(comp_params)
        format.html { redirect_to @comp, notice: 'Comp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comps/1
  # DELETE /comps/1.json
  def destroy
    @comp.destroy
    respond_to do |format|
      format.html { redirect_to comps_url }
      format.json { head :no_content }
    end
  end

  # 接口入口
  def comp
    operation = params[:operation]
    if operation == "search"
      key = params[:name]
      search_companys(key)
    elsif operation == "get"
      comp_id = params[:comp_id]
      get_company(comp_id)
    else
      all_companys
    end
  end

  # 获取所有公司
  def all_companys
    comps = Comp.all
    render json: comps
  end

  # 搜索公司
  def search_companys(key)
    p key
    comps = Comp.where("upper(comp_name) like upper('%#{key}%')")
    render json: comps
  end

  # 获取公司
  def get_company(comp_id)
    comps = Comp.where(["comp_id=?", comp_id])
    comp = comps.first

    if comp.nil?
      render json: nil
      return
    end

    company = {
      comp_id:  comp[:comp_id],
      comp_name:comp[:comp_name],
      area_code:comp[:area_code],
      tel:      comp[:tel],
      www:      comp[:www],
      brief:    comp[:brief],
    }

    company_ocharts = Array.new

    ocharts = Ochart.where(["comp_id=?", comp_id])
    ocharts.each do |var|
      company_ocharts.push({ochart_id:var[:ochart_id], department_name:var[:ochart_id], parent_id:var[:parent_id]})
    end
    company[:ochart] = company_ocharts

    render json: company
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comp
      @comp = Comp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comp_params
      params.require(:comp).permit(:comp_id, :comp_name, :area_code, :tel, :www, :brief)
    end
end
