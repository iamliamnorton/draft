class Player < ActiveRecord::Base
  belongs_to :team

  validates :name,
    presence: true

  validates :position,
    presence: true

  validates :salary,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }
end
