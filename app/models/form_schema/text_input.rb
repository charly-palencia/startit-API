class FormSchema::TextInput < ApplicationRecord
  validates :title, presence: true
  validates :required, absence: false

  belongs_to :form, class_name: 'FormSchema::Form'
end
