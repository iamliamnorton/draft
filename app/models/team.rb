class Team < ActiveRecord::Base
  belongs_to :sport

  has_many :players

  validates :sport_id,
    presence: true

  validates :name,
    presence: true,
    uniqueness: {
      scope: :sport_id,
      case_sensitive: false
    }
end
