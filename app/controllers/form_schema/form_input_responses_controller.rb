class FormSchema::FormInputResponsesController < ApplicationController

  def create
    resource = FormSchema::FormInputResponse.find_by(
      form_schema_form_instance_id: create_params[:form_schema_form_instance_id],
      form_schema_form_input_id: create_params[:form_schema_form_input_id],
    )

    if resource
      resource.update(update_params)
    else
      resource = FormSchema::FormInputResponse.new(create_params)
      resource.save
    end

    if resource.errors.empty?
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, :status => :bad_request
    end
  end

  def update
    resource = FormSchema::FormInputResponse.find(params[:id])
    if resource.update(update_params)
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
        .permit(
          :form_schema_form_instance_id,
          :form_schema_form_input_id,
          value: []
        )
    end

    def update_params
      params
      .require(:data)
      .require(:attributes)
      .permit(value: [])
    end
end
