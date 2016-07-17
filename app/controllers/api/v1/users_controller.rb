class Api::V1::UsersController < ApplicationController
	http_basic_authenticate_with :name => "admin", :password => "admin"
	before_filter :restrict_access
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def restrict_access
  api_key = ApiKey.find_by_access_token(params[:access_token])
  head :unauthorized unless api_key
end
end  