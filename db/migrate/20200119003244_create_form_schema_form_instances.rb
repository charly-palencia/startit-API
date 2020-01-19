class CreateFormSchemaFormInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :form_schema_form_instances do |t|
      t.datetime :finished_at
      t.integer :form_schema_form_id
      t.timestamps
    end
    add_foreign_key :form_schema_form_instances, :form_schema_forms, name: 'form_instances_form_indx'
  end
end
