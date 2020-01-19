class FormSchema::FormInput < ApplicationRecord
  validates :title, :type, type: { type: :string }, presence: true
  validates :required, type: { type: :boolean }, absence: false
  validates :description, type: { type: :string }
  validates :order, type: { type: :integer }, presence: true

  belongs_to :form, class_name: 'FormSchema::Form', foreign_key: :form_schema_form_id

  validates :form_schema_form_id, presence: true
end
