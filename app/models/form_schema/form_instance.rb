class FormSchema::FormInstance < ApplicationRecord
  belongs_to :form, class_name: 'FormSchema::Form'
end
