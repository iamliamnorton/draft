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

  validates :email,
    uniqueness: true,
    presence: true

  validates :credit,
    presence: true

  def guest?
    false
  end
end
