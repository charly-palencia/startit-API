class SerializableFlowInstance < JSONAPI::Serializable::Resource
  type 'flow_instances'

  has_many :users
  has_many :task_instances
  belongs_to :flow

  attribute :title
  attribute :user_ids
  attribute :status
end
