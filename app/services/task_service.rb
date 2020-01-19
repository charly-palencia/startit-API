class TaskService
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :title, :description, :flow_id, :resource, :relationships
  # validates_presence_of :title, :flow_id

  def initialize(args)
    assign_attributes(args)
  end

  def create
    build_object do
      validate!
      Task.transaction do
        form = FormSchema::Form.create!({})

        self.resource = Task.create!(
          title: title,
          description: description,
          flow_id: flow_id,
          form: form
        )
      end
    end
  end

  def update(resource)
    build_object do
      validate!
      Task.transaction do
        self.resource = resource.update_attributes!(
          title: title,
          description: description,
        )
      end
    end
  end


  def build_object(&action)
    begin
      action.call
    rescue ActiveModel::ValidationError, ActiveRecord::RecordInvalid => e
      record_errors = e.record.errors
      if e.record.is_a? FormSchema::Form
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
