class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :status
      t.references :mentee, null: false, foreign_key: true
      t.references :mentor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
