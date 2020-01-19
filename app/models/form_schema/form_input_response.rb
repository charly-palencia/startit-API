class FormSchema::FormInputResponse < ApplicationRecord
  belongs_to :text_input, class_name: 'FormSchema::TextInput'
end
