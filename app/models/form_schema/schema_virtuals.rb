module FormSchema::SchemaVirtuals
  def self.included(klass)
    klass.extend(ClassMethods)
    klass.validates_with FormSchema::InputSchemaValidator
  end

  module ClassMethods
    def define_schema_virtuals(*virtuals)
      virtuals.each do |virtual|
        virtual_str = virtual.to_s
        define_method(virtual) do
          schema[virtual_str]
        end
        define_method("#{virtual_str}=") do |attr|
          schema[virtual_str] = attr
        end
      end
    end
  end
end
