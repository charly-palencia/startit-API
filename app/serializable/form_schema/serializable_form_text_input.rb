module FormSchema
  class SerializableFormTextInput < FormSchema::SerializableFormInput
    type 'form_schema/form_text_inputs'

    attribute :title
    attribute :description
    attribute :required
    attribute :created_at
  end
end
