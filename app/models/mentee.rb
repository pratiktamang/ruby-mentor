class Mentee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :mentorships
  has_many :mentors, through: :mentorships
  has_many :projects
  has_many :tasks, through: :projects
  has_many :meetings
  has_one :mentee_profile, dependent: :destroy

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :seeking_mentorship, -> { where(seeking_mentorhip: true) }

  include PgSearch::Model
  pg_search_scope :text_search,
    against: %i[first_name last_name email],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

  FILTER_PARAMS = %i[query first_name last_name email].freeze

  def self.filter(filter_params)
    results = includes(:mentee_profile)

    if filter_params[:query].present?
      results = results.text_search(filter_params[:query])
    end

    results
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def profile
    mentee_profile
  end

  def city
    mentee_profile.city
  end

  def country
    mentee_profile.country
  end
end
