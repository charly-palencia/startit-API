class CreateInstanceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :instance_items do |t|
      t.datetime :finished_at
      t.json :evidence_result
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
