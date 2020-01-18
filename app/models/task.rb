class Task < ApplicationRecord
  belongs_to :flow
  belongs_to :form

  validates :title, presence: true
end
