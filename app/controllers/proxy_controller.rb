require 'open-uri'

class ProxyController < ApplicationController
  def host
    return 'http://192.168.1.201:8090'
  end

  def comp
    operation = params[:operation]

    if operation == "search"
      key = params[:key]
      res = open(URI.encode("#{host}/ochart/company/company_searchComp.do?operation=#{operation}&key=#{key}"))
      data = JSON.parse(res.read)

      data.delete_if { |comp| comp['comp_name'].rindex(key).nil? }

      p "========== #{data.class} =========="
      p data


    elsif operation == "get"
      comp_id = params[:comp_id]
      res = open(URI.encode("#{host}/ochart/company/company_searchComp.do?operation=#{operation}&comp_id=#{comp_id}"))
      data = JSON.parse(res.read)

      p "========== #{data.class} =========="
      p data
    end

    render json: data
  end

  def bid
    operation = params[:operation]

    if operation == "search"
      # &key=xxx&city=xxx&product=xxx
      key     = params[:key]
      city    = params[:city]
      product = params[:product]
      res = open(URI.encode("#{host}/bids/bids/bids_findBidsByCondition.do?operation=#{operation}&key=#{key}&city=#{city}&product=#{product}"))
      data = JSON.parse(res.read)

      p "========== #{data.class} =========="
      p data
    elsif operation == "book"
      # &id=xxx,xxx&time=YYYYMMDDhhmmss
      id   = params[:id]
      time = params[:time]
      res = open(URI.encode("#{host}/bids/bids/bids_findBidsByCondition.do?operation=#{operation}&id=#{id}&time=#{time}"))
      data = JSON.parse(res.read)

      p "========== #{data.class} =========="
      p data

    elsif operation == "get"
      # &id=xxx
      id = params[:id]
      res = open(URI.encode("#{host}/bids/bids/bids_findBidsByCondition.do?operation=#{operation}&id=#{id}"))
      data = JSON.parse(res.read)

      data[:created_time] = Time.new
      data[:bid_content] = "<html/>"

      p "========== #{data.class} =========="
      p data
    end

    render json: data
  end


end
