class User < ActiveRecord::Base
  has_many :contests

  has_many :entries

  has_many :entered_contests,
    class_name: "Contest",
    source: :contest,
    through: :entries

  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :confirmable,
    :lockable,
  # :timeoutable,
  # :omniauthable,
    :validatable

  # TODO email address validation
  validates :email,
    uniqueness: true,
    presence: true

  validates :credit,
    presence: true,
    numericality: {
      only_integer: true
    }

  def involved_in?(contest)
    contests.include?(contest) || entered_contests.include?(contest)
  end

  def can_enter?(contest)
    !involved_in?(contest) && contest.entries_remaining > 0
  end

  def guest?
    false
  end
end
