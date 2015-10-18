class Game < ActiveRecord::Base
  belongs_to :sport

  belongs_to :round

  belongs_to :team

  has_many :stats
end
