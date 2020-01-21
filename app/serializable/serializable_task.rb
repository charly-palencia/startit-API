class SerializableTask < JSONAPI::Serializable::Resource
  type 'tasks'

  attribute :title
  attribute :description
  attribute :order
  attribute :flow_id
  attribute :created_at
  attribute :updated_at

  belongs_to :form
end
