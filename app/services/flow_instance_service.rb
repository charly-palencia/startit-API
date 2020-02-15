class FlowInstanceService
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :title, :due_date, :flow_id, :user_ids, :resource

  def initialize(args, action_user)
    assign_attributes(args)
    @attributes = args
    @action_user = action_user
  end

  def create
    build_object do
      validate!
      FlowInstance.transaction do
        self.resource = FlowInstance.create!(@attributes.merge(created_by: @action_user))
        resource.flow.tasks.each do |task|
          next unless task.form
          FormSchema::FormInstance.create!(form: task.form)
        end
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
