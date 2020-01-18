class UsersController < ApplicationController
  def index
    resources = User.limit(10)
    render jsonapi: resources
  end
end
