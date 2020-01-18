class TaskService
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :title, :description, :flow_id, :resource, :relationships, :form_attributes
  # validates_presence_of :title, :flow_id

  def initialize(args, form_attributes)
    assign_attributes(args)
    self.form_attributes = form_attributes
    self.relationships = {}
  end

  def create
    build_object do
      validate!
      Task.transaction do
        self.relationships[:form] = Form.create!(form_attributes)
        self.resource = Task.create!(
          title: title,
          description: description,
          flow_id: flow_id,
          form_id: relationships[:form].id
        )
      end
    end
  end

  def update(resource)
    build_object do
      validate!
      Task.transaction do
        self.relationships[:form] = if resource.form
          resource.form.update_attributes!(form_attributes)
          resource.form
        else
          Form.create!(form_attributes)
        end

        self.resource = resource.update_attributes!(
          title: title,
          description: description,
          form_id: relationships[:form].id
        )
      end
    end
  end


  def build_object(&action)
    begin
      action.call
    rescue ActiveModel::ValidationError, ActiveRecord::RecordInvalid => e
      record_errors = e.record.errors
      if e.record.is_a? Form
        record_errors.to_h.each do |field, error|
          errors.add!(:form, error)
        end
      else
        errors.merge!(record_errors)
      end
      return false
    end
  end
end
