class CreateFormSchemaForms < ActiveRecord::Migration[5.2]
  def change
    create_table :form_schema_forms do |t|
      t.timestamps
    end
  end
end
