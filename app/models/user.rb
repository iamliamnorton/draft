class User < ActiveRecord::Base
  has_many :contests

  has_many :entries

  has_many :rosters

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
      only_integer: true,
      greater_than_or_equal_to: 0
    }

  def guest?
    false
  end
end
