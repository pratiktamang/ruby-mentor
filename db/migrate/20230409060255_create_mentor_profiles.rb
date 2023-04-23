class CreateMentorProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :mentor_profiles do |t|
      t.references :mentor, null: false, foreign_key: true
      t.string :company_url
      t.date :ruby_start_year
      t.string :country
      t.string :city
      t.string :twitter
      t.string :github
      t.string :personal_site
      t.text :past_workplaces
      t.boolean :previous_mentoring
      t.text :motivation
      t.string :learning_preference
      t.string :availability
      t.string :industry_expertise
      t.text :specific_interests

      t.timestamps
    end
  end
end
