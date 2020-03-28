module FormSchema
  class SerializableFormInstance < JSONAPI::Serializable::Resource
    type 'form_schema/form_instances'
  end
end
