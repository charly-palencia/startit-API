class FormSchema::TextInput < ApplicationRecord
  validates :title, presence: true
  validates :required, absence: false

  belongs_to :form, class_name: 'FormSchema::Form', foreign_key: :form_schema_form_id

  validates :form_schema_form_id, presence: true
end
