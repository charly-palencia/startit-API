module FormSchema
  class SerializableTextInput < JSONAPI::Serializable::Resource
    type 'form_schema/text_inputs'

    attribute :title
    attribute :description
    attribute :required
    attribute :created_at
  end
end
