module FormSchema
  class SerializableFormInputResponse < JSONAPI::Serializable::Resource
    type 'form_schema/form_input_responses'

    attribute :form_schema_form_instance_id
    attribute :form_schema_form_input_id
    attribute :value
  end
end
