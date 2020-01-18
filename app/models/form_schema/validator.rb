module FormSchema
  class Validator < ActiveModel::Validator
    def validate(form)
      form_schema = FormSchema::Form.new(form.schema)
      validate_schema(form, form_schema);
    end

    private
    def validate_schema(form, schema)
      if !schema.valid?
        schema.errors.to_h.each do |field, error|
          form.errors.add(:schema, "attribute #{field} #{error}")
        end
      else
        schema.schema_hash.each do |field_name, field|
          if (field.is_a? Array)
            field.each do |sub_field|
              next unless sub_field.is_a?(Hash)
              validate_schema(form, initialize_schema_class(sub_field))
            end
          elsif field.is_a?(Hash)
            validate_schema(form, initialize_schema_class(field))
          end
        end
      end
    end

    def initialize_schema_class(schema_object)
      FormSchema::TextInput.new(schema_object)
    end
  end
end
