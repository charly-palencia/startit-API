class SerializableTask < JSONAPI::Serializable::Resource
  type 'tasks'

  belongs_to :form

  attribute :title
  attribute :description
  attribute :order
  attribute :flow_id
  attribute :form_schema_form_id
  attribute :created_at
  attribute :updated_at


end
