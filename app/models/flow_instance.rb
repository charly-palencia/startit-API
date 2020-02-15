class FlowInstance < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :flow
  has_and_belongs_to_many :users

  validates :flow, presence: true
  validates :users, presence: true
  validates :status, presence: true
end
