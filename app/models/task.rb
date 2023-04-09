class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: {in: %w[not_started in_progress completed]}
end
