class MentorProfile < ApplicationRecord
  belongs_to :mentor

  validates :company_url, presence: true
  validates :ruby_start_year, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :previous_mentoring, presence: true
  validates :motivation, presence: true
  validates :communication_preference, presence: true
  validates :availability, presence: true
  validates :industry_expertise, presence: true
  validates :specific_interests, presence: true

  serialize :availability, Array
  accepts_nested_attributes_for :mentor
end
