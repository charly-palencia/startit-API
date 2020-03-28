class FormSchema::FormInputResponse < ApplicationRecord
  belongs_to :form_instance, class_name: 'FormSchema::FormInstance', foreign_key: 'form_schema_form_instance_id'

  validates :form_schema_form_instance_id, uniqueness: {scope: :form_schema_form_input_id} #Add DBindex
end
