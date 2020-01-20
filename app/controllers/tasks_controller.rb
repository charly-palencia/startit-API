class TasksController < ApplicationController
  respond_to :json

  def index
    resources = Task.where(flow_id: params[:flow_id]).includes(form: :form_inputs).order('"order" ASC')
    render jsonapi: resources, include: [form: :form_inputs]
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
        .permit(:title, :description, :flow_id, :order)
    end

    def update_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:title, :description, :order)
    end
end
