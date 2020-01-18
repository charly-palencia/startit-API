class TaskService
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :title, :description, :flow_id, :resource, :relationships, :form_attributes
  validates_presence_of :title, :description, :flow_id

  def initialize(args, form_attributes)
    assign_attributes(args)
    self.form_attributes = form_attributes
    Rails.logger.info 'A'*1222
    Rails.logger.info args
    Rails.logger.info form_attributes
    self.relationships = {}
  end

  def create
    return false if !valid?
    begin
      Task.transaction do
        self.relationships[:form] = Form.create!(form_attributes)
        self.resource = Task.create!(
          title: title,
          description: description,
          flow_id: flow_id,
          form_id: relationships[:form].id
        )
      end
    rescue => e
      Rails.logger.info 'b'*100
      Rails.logger.info e.message
      record_errors = e.record.errors
      if e.record.is_a? Form
        record_errors.to_h.each do |field, error|
          if field == 'base'
            errors.add(:base, error)
          else
            errors.add(:form, error)
          end
        end
      else
        errors.merge!(record_errors)
      end
      return false
    end
  end
end
