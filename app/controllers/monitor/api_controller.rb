class Monitor::ApiController < ApplicationController
  include Response

  DEFAULT_PAGE = 1
  DEFAULT_LIMIT_VALUE = 25
  DEFAULT_START_DATE = '1990-01-01'
  DEFAULT_END_DATE = Time.now

  def index
    response = ActiveModel::SerializableResource.new(requests).to_json
    json_response(requests)
  end

  private

  def requests
    conditions = {}
    conditions[:created_at] = start_at..end_at
    conditions[:ip] = params[:ip] unless params[:ip].nil?
    conditions[:path] = params[:path] unless params[:path].nil?

    IpHistory.where(conditions)
      .page(page)
      .per(limit_value)
  end

  def page
    params[:page].nil? ? DEFAULT_PAGE : params[:page].to_i
  end

  def limit_value
    params[:limit_value].nil? ? DEFAULT_LIMIT_VALUE : params[:limit_value].to_i
  end

  def start_at
    params[:start_at].nil? ? DEFAULT_START_DATE : params[:start_at]
  end

  def end_at
    params[:end_at].nil? ? DEFAULT_END_DATE : params[:end_at]
  end
end
