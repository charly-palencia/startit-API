class SerializableForm < JSONAPI::Serializable::Resource
  type 'forms'

  attribute :schema
end
