class FormSchema::Form < ApplicationRecord
  has_many :inputs, class_name: 'FormSchema::FormInput', foreign_key: :form_schema_form_id
end
