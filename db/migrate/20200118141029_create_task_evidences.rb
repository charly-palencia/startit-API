class CreateTaskEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :task_evidences do |t|
      t.string :name
      t.string :type
      t.text :description
      t.boolean :is_required
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
