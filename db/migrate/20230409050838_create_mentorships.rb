class CreateMentorships < ActiveRecord::Migration[7.0]
  def change
    create_table :mentorships do |t|
      t.references :mentor, null: false, foreign_key: true
      t.references :mentee, null: false, foreign_key: true
      t.text :match_reasons

      t.timestamps
    end
  end
end
