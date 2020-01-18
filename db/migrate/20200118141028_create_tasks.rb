class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :embedded_url
      t.string :code
      t.string :random_color
      t.references :flow, foreign_key: true
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
