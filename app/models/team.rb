class Team < ActiveRecord::Base
  belongs_to :sport

  validates :name,
    uniqueness: {scope: :sport_id},
    presence: true
end
