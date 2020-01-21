module FormSchema
  class SerializableForm < JSONAPI::Serializable::Resource
    type 'form_schema/forms'

    attribute :created_at

    has_many :inputs
  end
end
