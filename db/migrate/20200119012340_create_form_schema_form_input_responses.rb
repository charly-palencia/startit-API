class CreateFormSchemaFormInputResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :form_schema_form_input_responses do |t|
      t.jsonb :value
      t.integer :form_schema_form_instance_id
      t.integer :form_schema_form_input_id
      t.timestamps
    end
    add_foreign_key :form_schema_form_input_responses, :form_schema_form_instances, name: 'form_input_responses_form_instances_indx'
    add_foreign_key :form_schema_form_input_responses, :form_schema_form_inputs, name: 'form_input_responses_form_input_indx'
  end
end
