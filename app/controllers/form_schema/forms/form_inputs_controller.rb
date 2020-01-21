class FormSchema::Forms::FormInputsController < ApplicationController
  def index
    form = FormSchema::Form.find(params[:form_id])
    resources = form.form_inputs.order('"order" ASC')
    render jsonapi: resources
  end

  def create
    form = FormSchema::Form.find(params[:form_id])
    resource = form.form_inputs.build(create_params)
    if resource.save
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  def update
    form = FormSchema::Form.find(params[:form_id])
    resource = form.form_inputs.find(params[:id])
    if resource.update(create_params)
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  def destroy
    form = FormSchema::Form.find(params[:form_id])
    resource = form.form_inputs.find(params[:id])
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
        .permit(:title, :description, :required, :type, :order, options: [])
    end

    def update_params
      params
      .require(:data)
      .require(:attributes)
      .permit(:title, :description, :required, :order, :options)
    end
end
