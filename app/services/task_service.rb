class TaskService
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :title, :description, :flow_id, :order, :resource

  def initialize(args)
    assign_attributes(args)
    @attributes = args
  end

  def create
    build_object do
      validate!
      Task.transaction do
        form = FormSchema::Form.create!
        self.resource = Task.create!(@attributes.merge(form: form))
        resource
      end
    end
  end

  def update(resource)
    self.resource = resource
    build_object do
      validate!
      Task.transaction do
        resource.update_attributes!(@attributes)
        resource
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
