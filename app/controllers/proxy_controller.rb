class ProxyController < ApplicationController
  def show
    render json: { error: request.env['ERROR_INFO'] }
  end
end
