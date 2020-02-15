class TaskInstance < ApplicationRecord
  include AASM

  belongs_to :task
  belongs_to :flow_instance
  belongs_to :form_instance, class_name: 'FormSchema::FormInstance', foreign_key: :form_schema_form_instance_id

  validates :task, presence: true
  validates :status, presence: true
  validates :flow_instance, presence: true

  aasm column: :status do
    state :new, initial: true
  end
end
