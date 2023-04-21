class CreateMenteeProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :mentee_profiles do |t|
      t.references :mentee, null: false, foreign_key: true
      t.string :country
      t.string :city
      t.string :workplace_url
      t.boolean :writing_ruby
      t.string :start_source
      t.string :underrepresented_group
      t.string :twitter
      t.string :github
      t.string :personal_site
      t.string :other_languages
      t.string :past_career
      t.text :mentoring_goals
      t.string :communication_preference
      t.string :availability
      t.string :desired_industry
      t.text :specific_interests

      t.timestamps
    end
  end
end
