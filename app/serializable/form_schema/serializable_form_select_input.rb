module FormSchema
  class SerializableFormSelectInput < FormSchema::SerializableFormInput
    type 'form_schema/form_select_inputs'

    attribute :options
  end
end
