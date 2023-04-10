class MenteeProfile < ApplicationRecord
  belongs_to :mentee

  validates :country, presence: true
  validates :city, presence: true
  validates :workplace_url, presence: true
  validates :writing_ruby, presence: true
  validates :start_source, presence: true
  validates :underrepresented_group, presence: true
  validates :mentoring_goals, presence: true
end
