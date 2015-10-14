class User < ActiveRecord::Base
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
