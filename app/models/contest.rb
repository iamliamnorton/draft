class Contest < ActiveRecord::Base
  WIN_SHARE = 0.9

  belongs_to :user

  belongs_to :round

  has_many :games,
    through: :round

  has_many :entries

  has_many :rosters

  has_many :contestants,
    class_name: "User",
    through: :entries,
    source: :user

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

  validates :salary_cap,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 10_000,
      less_than_or_eqaul_to: 100_000
    }

  def self.unsettled
    where(settled_at: nil)
  end

  def self.open
    unsettled.
      joins(:round).
      merge(Round.open)
  end

  delegate :open?,
    to: :round,
    prefix: true

  def prize
    Integer 2 * entry * WIN_SHARE
  end

  def settled?
    !!settled_at
  end
end
