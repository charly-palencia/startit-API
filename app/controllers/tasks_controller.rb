class TasksController < ApplicationController
  respond_to :json

  def index
    resources = Task.includes(:form).limit(10)
    render jsonapi: resources, include: [:form]
  end

  def create
    resource_service = TaskService.new(create_params, form_attributes)
    if resource_service.create
      render jsonapi: resource_service.resource, include: [:form]
    else
      render jsonapi_errors: resource_service.errors, :status => :bad_request
    end
  end

  def update
    resource = Task.find(params[:id])
    if resource.update_attributes(update_params)
      render jsonapi: resource
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

    def form_attributes
      params
        .require(:data)
        .require(:relationships)
        .require(:form)
        .require(:data)
        .require(:attributes)
        .permit(:schema)
    end

    def update_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:title, :description)
    end
end
