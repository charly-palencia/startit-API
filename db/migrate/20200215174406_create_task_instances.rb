class CreateTaskInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :task_instances do |t|
      t.references :task, foreign_key: true
      t.datetime :due_date
      t.string :status

      t.timestamps
    end
  end
end
