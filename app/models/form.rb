class Form < ApplicationRecord
  validates_with FormSchema::Validator
end
