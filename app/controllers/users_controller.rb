class UsersController < ApplicationController
  def index
    resources = User.page(params[:page]).per(params[:page_size])
    render jsonapi: resources
  end
end
