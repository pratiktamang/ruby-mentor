class Mentorship < ApplicationRecord
  belongs_to :mentor
  belongs_to :mentee

  attribute :match_reasons, :text
end
