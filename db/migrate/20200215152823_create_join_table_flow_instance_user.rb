class CreateJoinTableFlowInstanceUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :flow_instances, :users do |t|
      t.index [:flow_instance_id, :user_id]
      # t.index [:user_id, :flow_instance_id]
    end
  end
end
