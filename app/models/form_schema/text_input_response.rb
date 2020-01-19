class FormSchema::TextInputResponse < ApplicationRecord
  belongs_to :text_input, class_name: 'FormSchema::TextInput'
end
