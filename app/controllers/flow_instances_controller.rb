class FlowInstancesController < ApplicationController
  respond_to :json

  def index
    resources = FlowInstance.limit(10)
    render jsonapi: resources, include: [:flow, :users]
  end

  def create
    flow_instance_service = FlowInstanceService.new(create_params, current_user);
    if flow_instance_service.create
      render jsonapi: flow_instance_service.resource
    else
      render jsonapi_errors: flow_instance_service.errors, :status => :bad_request
    end
  end

  def update
    flow = FlowInstance.find(params[:id])
    if flow.update(update_params)
      render jsonapi: flow
    else
      render jsonapi_errors: flow.errors, :status => :bad_request
    end
  end

  def show
    flow = FlowInstance.find(params[:id])
    render jsonapi: flow
  end

  private
    def create_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:title, :flow_id, :due_date, user_ids: [])
    end

    def update_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:title, :due_date, user_ids: [])
    end
end
