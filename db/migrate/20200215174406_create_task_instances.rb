class CreateTaskInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :task_instances do |t|
      t.references :task, foreign_key: true
      t.references :flow_instance, foreign_key: true
      t.integer :form_schema_form_instance_id
      t.datetime :due_date
      t.string :status

      t.timestamps
    end

    add_foreign_key :task_instances, :form_schema_form_instances, name: 'task_instances_form_intsance_indx'
  end
end
