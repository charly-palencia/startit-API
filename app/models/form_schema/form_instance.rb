class FormSchema::FormInstance < ApplicationRecord
  belongs_to :form, class_name: 'FormSchema::Form', foreign_key: :form_schema_form_id
end
