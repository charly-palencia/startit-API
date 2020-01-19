module FormSchema
  class InputSchemaValidator < ActiveModel::Validator
    def validate(input)
      class_name = input.class.name.split('::').last
      schema_klass = "FormSchema::Schema::#{class_name}Schema".constantize
      input_schema = schema_klass.new(input.schema)
      if !input_schema.valid?
        input_schema.errors.to_h.each do |field, error|
          input.errors.add(field, error)
        end
      end
    end
  end
end
