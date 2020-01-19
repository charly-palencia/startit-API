class FormSchema::Schema::FormSelectInputSchema
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :options
  validates :options, type: { type: :array }, presence: true

  def initialize(args)
      assign_attributes(args)
    end
end
