class FormSchema::FormSelectInput < FormSchema::FormInput
  include FormSchema::SchemaVirtuals
  define_schema_virtuals :options
end
