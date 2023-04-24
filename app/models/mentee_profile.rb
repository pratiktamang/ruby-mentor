class MenteeProfile < ApplicationRecord
  belongs_to :mentee

  validates :country, presence: true
  validates :city, presence: true
  validates :workplace_url, presence: true
  validates :writing_ruby, inclusion: {in: [true, false]}
  validates :start_source, presence: true
  validates :underrepresented_group, presence: true
  validates :mentoring_goals, presence: true
  validates :learning_preferences, presence: true
  validates :desired_industry, presence: true
  validates :specific_interests, presence: true
  validates :availability, presence: true

  accepts_nested_attributes_for :mentee

  DAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze
  LEARNING_PREFERENCES = %i[visual auditory kinesthetic social reading solitary].freeze
end
