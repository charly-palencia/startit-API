module FormSchema
  class Form
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment

    attr_accessor :fields, :schema_hash

    validates :fields, type: { type: :array }, absence: false

    def initialize(args)
      self.schema_hash = args
      assign_attributes(args)
    end
  end
end
