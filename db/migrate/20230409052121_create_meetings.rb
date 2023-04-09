class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :title
      t.datetime :date_time
      t.references :mentor, null: false, foreign_key: true
      t.references :mentee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
