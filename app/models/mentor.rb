class Mentor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :mentorships
  has_many :mentees, through: :mentorships
  has_many :projects
  has_many :tasks, through: :projects
  has_many :meetings
  has_one :mentor_profile, dependent: :destroy

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :available, -> { where(available: true) }

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
    results = includes(:mentor_profile)

    if filter_params[:query].present?
      results = results.text_search(filter_params[:query])
    end

    results
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def profile
    mentor_profile
  end

  def city
    mentor_profile.city
  end

  def country
    mentor_profile.country
  end
end
