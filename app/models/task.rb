class Task < ApplicationRecord
  belongs_to :flow
  belongs_to :form
end
