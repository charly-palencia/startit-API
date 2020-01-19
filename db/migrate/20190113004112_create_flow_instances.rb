class CreateFlowInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :flow_instances do |t|
      t.references :responsable, foreign_key: {to_table: :users}
      t.datetime :started_at
      t.datetime :finished_at
      t.references :flow, foreign_key: true

      t.timestamps
    end
  end
end
