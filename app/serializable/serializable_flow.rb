class SerializableFlow < JSONAPI::Serializable::Resource
  type 'flows'

  attribute :title
  attribute :description
  attribute :default_responsable_id
  attribute :created_at
  attribute :updated_at
end
