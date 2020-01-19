class FormSchema::FormSelectInput < FormSchema::FormInput
  include FormSchema::SchemaVirtuals
  define_virtuals(:options)
end
