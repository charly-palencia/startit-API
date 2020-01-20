module FormSchema
  class SerializableForm < JSONAPI::Serializable::Resource
    type 'form_schema/forms'

    has_many :form_inputs
    
    attribute :created_at
  end
end
