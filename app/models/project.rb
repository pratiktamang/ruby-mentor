class Project < ApplicationRecord
  belongs_to :mentee
  belongs_to :mentor
  has_many :tasks

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: {in: %w[not_started in_progress completed]}
end
