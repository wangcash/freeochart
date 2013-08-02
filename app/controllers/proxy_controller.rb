require 'open-uri'

class ProxyController < ApplicationController
  def host
    return 'http://192.168.1.201:8090'
  end

  def transmit(url)
    puts "#{url}"

    begin
      res  = open(URI.encode(url))
      data = JSON.parse(res.read)
      puts "========== #{data.class} =========="
      puts data
    rescue  StandardError,Timeout::Error, SystemCallError, Errno::ECONNREFUSED
      10.times do |variable|
        puts '老杨还没开机呢....'
      end
      data = nil
    end

    return data
  end

  def comp
    operation = params[:operation]

    if operation == "search"
      name = params[:name]

      data = transmit("#{host}/ochart/company/company_searchComp.do?operation=#{operation}&name=#{name}")

      # fixbug: 没有对name进行like处理。
      data.delete_if { |comp| comp['comp_name'].rindex(name).nil? }

    elsif operation == "get"
      comp_id = params[:comp_id]

      data = transmit("#{host}/ochart/company/company_searchComp.do?operation=#{operation}&comp_id=#{comp_id}")
    end

    render json: data
  end

  def bid
    operation = params[:operation]

    if operation == "search"
      key     = params[:key]
      city    = params[:city]
      product = params[:product]

      data = transmit("#{host}/bids/bids/bids_findBidsByCondition.do?operation=#{operation}&key=#{key}&city=#{city}&product=#{product}")
    elsif operation == "book"
      id   = params[:id]
      time = params[:time]

      data = transmit("#{host}/bids/bids/bids_findBidsByCondition.do?operation=#{operation}&id=#{id}&time=#{time}")
    elsif operation == "get"
      id = params[:id]

      data = transmit("#{host}/bids/bids/bids_findBidsByCondition.do?operation=#{operation}&id=#{id}")
    end

    render json: data
  end


end
