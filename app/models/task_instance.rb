class TaskInstance < ApplicationRecord
  include AASM

  belongs_to :task

  validates :task, presence: true
  validates :status, presence: true

  aasm column: :status do
    state :new, initial: true
  end
end
