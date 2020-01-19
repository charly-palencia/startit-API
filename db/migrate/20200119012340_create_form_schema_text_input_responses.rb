class CreateFormSchemaTextInputResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :form_schema_text_input_responses do |t|
      t.string :value
      t.integer :form_schema_form_instance_id
      t.string :input_id
      t.timestamps
    end
    add_foreign_key :form_schema_text_input_responses, :form_schema_form_instances, name: 'text_input_responses_form_instances_indx'
  end
end
