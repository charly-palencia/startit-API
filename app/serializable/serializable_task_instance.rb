class SerializableTaskInstance < JSONAPI::Serializable::Resource
  type 'task_instances'

  belongs_to :task
  belongs_to :form_instance

  attribute :due_date
  attribute :status
  attribute :task_id
  attribute :created_at
  attribute :updated_at
end
