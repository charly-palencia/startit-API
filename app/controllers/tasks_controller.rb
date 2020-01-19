class TasksController < ApplicationController
  respond_to :json

  def index
    resources = Task.includes(:form)
    render jsonapi: resources, include: [:form]
  end

  def create
    resource_service = TaskService.new(create_params)
    if resource_service.create
      render jsonapi: resource_service.resource, include: [:form]
    else
      render jsonapi_errors: resource_service.errors, :status => :bad_request
    end
  end

  def update
    resource = Task.find(params[:id])
    resource_service = TaskService.new(update_params)
    if resource_service.update(resource)
      render jsonapi: resource, include: [:form]
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  def destroy
    resource = Task.find(params[:id])
    if resource.destroy
      render jsonapi: resource, include: [:form]
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  private
    def create_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:title, :description, :flow_id)
    end

    def update_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:title, :description)
    end
end
