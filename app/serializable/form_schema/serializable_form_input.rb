module FormSchema
  class SerializableFormInput < JSONAPI::Serializable::Resource
    type 'form_schema/form_inputs'

    attribute :title
    attribute :description
    attribute :required
    attribute :created_at
  end
end
