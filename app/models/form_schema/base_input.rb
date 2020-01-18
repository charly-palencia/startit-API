module FormSchema
  class BaseInput
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment

    attr_accessor :id, :type, :title, :description, :required, :schema_hash

    validates :type, type: { type: :string }, presence: true
    validates :title, type: { type: :string }, presence: true
    validates :required, type: { type: :boolean }, absence: false


    def initialize(args)
      self.schema_hash = args
      assign_attributes(args)
    end
  end
end
