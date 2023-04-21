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

  scope :seeking_mentorship, -> { where(seeking: true) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
