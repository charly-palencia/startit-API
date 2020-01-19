class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :embedded_url
      t.string :code
      t.string :random_color
      t.integer :form_schema_form_id
      t.references :flow, foreign_key: true
      t.timestamps
    end
    add_foreign_key :tasks, :form_schema_forms
  end
end
