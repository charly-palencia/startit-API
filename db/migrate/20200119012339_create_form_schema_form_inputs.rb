class CreateFormSchemaFormInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :form_schema_form_inputs do |t|
      t.string :title, null: false
      t.string :description
      t.boolean :required, null: false
      t.integer :order, null: false
      t.jsonb    :schema, null: false, default: {}
      t.string :type, null: false
      t.integer :form_schema_form_id
      t.timestamps
    end
    add_foreign_key :form_schema_form_inputs, :form_schema_forms, name: 'form_input_form_indx'
  end
end
