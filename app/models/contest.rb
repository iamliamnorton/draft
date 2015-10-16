class Contest < ActiveRecord::Base
  belongs_to :user

  belongs_to :round

  has_many :entries

  has_many :contestants,
    class_name: "User",
    through: :entries

  validates :round,
    presence: true

  validates :entry,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1_00,
      less_than_or_eqaul_to: 10_000_00
    }

  validates :min_entries,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validates :max_entries,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  validates :cap,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 10_000,
      less_than_or_eqaul_to: 100_000
    }

  def self.open
    joins(:round).merge(Round.open)
  end

  def prize
    (2 * entry) * 0.9
  end
end
