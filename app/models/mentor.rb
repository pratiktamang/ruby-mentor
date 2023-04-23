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
