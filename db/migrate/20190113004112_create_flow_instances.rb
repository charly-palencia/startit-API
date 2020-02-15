class CreateFlowInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :flow_instances do |t|
      t.string :title, null: false
      t.string :status, null: false
      t.references :created_by, foreign_key: {to_table: :users}
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :due_date
      t.references :flow, foreign_key: true

      t.timestamps
    end
  end
end
