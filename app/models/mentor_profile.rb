class MentorProfile < ApplicationRecord
  belongs_to :mentor

  validates :company_url, presence: true
  validates :ruby_start_year, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :previous_mentoring, presence: true
  validates :motivation, presence: true

  accepts_nested_attributes_for :mentor
end
