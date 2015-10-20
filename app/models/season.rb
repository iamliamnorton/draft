class Season < ActiveRecord::Base
  has_many :teams

  has_many :games

  validates :name,
    presence: true

  validates :year,
    presence: true

  validates :max_draft_picks,
    presence: true
end
