class TaskInstancesController < ApplicationController
  respond_to :json

  def update
    resource = TaskInstance.find(params[:id])
    if resource.update(update_params)
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  private

    def update_params
      params
        .require(:data)
        .require(:attributes)
        .permit(:due_date)
    end
end
