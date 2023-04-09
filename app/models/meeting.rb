class Meeting < ApplicationRecord
  belongs_to :mentor
  belongs_to :mentee

  validates :title, presence: true
  validates :date_time, presence: true
end
