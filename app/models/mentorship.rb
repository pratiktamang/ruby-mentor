class Mentorship < ApplicationRecord
  belongs_to :mentor
  belongs_to :mentee

  attribute :match_reasons, :text

  include PgSearch::Model
  pg_search_scope :text_search,
    associated_against: {
      mentor: %i[first_name last_name email],
      mentee: %i[first_name last_name email]
    },
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

  FILTER_PARAMS = %i[query first_name last_name email].freeze

  def self.filter(filter_params)
    results = includes(:mentor, :mentee)

    if filter_params[:query].present?
      results = results.text_search(filter_params[:query])
    end

    results
  end
end
