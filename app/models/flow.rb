class Flow < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :default_responsable,  class_name: 'User'
  has_many :tasks
end
