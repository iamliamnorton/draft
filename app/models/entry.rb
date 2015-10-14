class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  validates :contest,
    presence: true

  validates :user,
    presence: true
end
