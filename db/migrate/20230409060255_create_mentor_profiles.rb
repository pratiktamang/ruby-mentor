class CreateMentorProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :mentor_profiles do |t|
      t.references :mentor, null: false, foreign_key: true
      t.string :company_url
      t.integer :ruby_start_year
      t.string :country
      t.string :city
      t.string :twitter
      t.string :github
      t.string :personal_site
      t.text :past_workplaces
      t.boolean :previous_mentoring
      t.text :motivation

      t.timestamps
    end
  end
end
