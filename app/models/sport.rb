class Sport < ActiveRecord::Base
  has_many :teams

  has_many :games

  validates :name,
    presence: true
end
