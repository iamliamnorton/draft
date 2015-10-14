class User < ActiveRecord::Base
  has_many :entries

  has_many :contests,
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

  def guest?
    false
  end
end
