class FlowInstance < ApplicationRecord
  include AASM

  belongs_to :created_by, class_name: 'User'
  belongs_to :flow
  has_and_belongs_to_many :users

  has_many :tasks, through: :flow
  has_many :task_instances, through: :tasks

  validates :flow, presence: true
  validates :users, presence: true
  validates :status, presence: true

  aasm column: :status do
    state :new, initial: true
  end
end
