class FormSchema::FormInputsController < ApplicationController
  def create
    resource = FormSchema::FormInput.new(create_params)
    if resource.save
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  def update
    resource = FormSchema::FormInput.find(params[:id])
    if resource.update(create_params)
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  def destroy
    resource = FormSchema::FormInput.find(params[:id])
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
        .permit(:title, :description, :required, :type, :order, :form_schema_form_id, options: [])
    end

    def update_params
      params
      .require(:data)
      .require(:attributes)
      .permit(:title, :description, :required, :order, :options)
    end
end
