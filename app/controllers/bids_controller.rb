class City
  def initialize id, name
    @id, @name = id, name
  end

  def id
    return @id
  end

  def name
    return @name
  end
end

class Product
  def initialize id, name
    @id, @name = id, name
  end

  def id
    return @id
  end

  def name
    return @name
  end
end

class BidsController < ApplicationController
  require 'time'

  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    init_variable
    @comps = Comp.all
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bid }
      else
        format.html { render action: 'new' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url }
      format.json { head :no_content }
    end
  end

  # 接口入口
  def bid
    operation = params[:operation]
    if operation == "search"
      key = params[:name]
      search_companys(key)
    elsif operation == "get"
      comp_id = params[:comp_id]
      get_company(comp_id)
    elsif operation == "book"
      book
    else
      all_companys
    end
  end

  def book
    # ?operation=book&id=xxx,xxx&time=YYYYMMDDhhmmss
    ids       = params[:id].split(',')
    time      = params[:time]

    sql_ids = "''"
    ids.each do |id|
      sql_ids << ", '#{id}'"
    end

    if time == ""
      bids = Bid.where("bid_organ_id in (#{sql_ids})")
    else
      timestamp = Time.parse(params[:time])
      bids = Bid.where("bid_organ_id in (#{sql_ids})").where("created_at > '#{timestamp}'")
    end

    @bids = Array.new

    bids.each do |bid|
      @bids.push({
        bid_id:          "#{bid.id}",
        bid_name:        bid.bid_name,
        bid_organ:       Comp.where(["comp_id=?", bid.bid_organ_id]).first.comp_name,
        bid_organ_id:    bid.bid_organ_id,
        bid_amount:      bid.bid_amount,
        bid_number:      bid.bid_number,
        bid_begin_date:  bid.bid_begin_date,
        bid_finish_date: bid.bid_finish_date,
        city_id:         bid.city_id,
        products_id:     bid.products_id,
        created_time:    bid.created_at,
        bid_link:        bid.bid_link
        })
    end

    render json: @bids
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:bid_name, :bid_organ_id, :bid_amount, :bid_number, :bid_begin_date, :bid_finish_date, :city_id, :products_id, :bid_content, :bid_link)
    end

    def init_variable
      @cities   = [City.new('110000', '北京市'), City.new('120000', '天津市'), City.new('310000', '上海市'), City.new('500000', '重庆市')]
      @products = [
        Product.new('402888ee3da133fd013da1567e1e0016','电脑'),
        Product.new('402888ee3da133fd013da1567e610017','笔记本'),
        Product.new('402888ee3da133fd013da1567faf001c','台式机'),
        Product.new('402888ee3dede92c013dedf82c9c001a','服务器'),
        Product.new('402888ee3da133fd013da1567e610017,402888ee3da133fd013da1567faf001c','笔记本,台式机'),
        Product.new('402888ee3da133fd013da1567e610017,402888ee3da133fd013da1567faf001c,402888ee3dede92c013dedf82c9c001a','笔记本,台式机,服务器')
      ]
    end
end
