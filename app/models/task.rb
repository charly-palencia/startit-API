class Task < ApplicationRecord
  belongs_to :flow
  belongs_to :form, class_name: 'FormSchema::Form', foreign_key: :form_schema_form_id, dependent: :destroy

  validates :title, presence: true
end
