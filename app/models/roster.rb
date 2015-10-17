class Roster < ActiveRecord::Base
  belongs_to :user

  belongs_to :contest

  has_many :draft_picks

  def self.for_user(user)
    where(user: user)
  end
end
