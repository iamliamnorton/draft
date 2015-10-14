class Contest < ActiveRecord::Base
  DEFAULT_CAP = 2

  has_many :entries

  has_many :users,
    through: :entries

  validates :entry,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1_00,
      less_than_or_eqaul_to: 10_000_00
    }

  validates :cap,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 2,
      less_than_or_eqaul_to: 10_000
    }

  def self.open
    where(
      won_at: nil,
      closed_at: nil,
      cancelled_at: nil
    )
  end

  def self.cancelled
    where.not(cancelled_at: nil)
  end

  after_initialize do
    self.cap ||= DEFAULT_CAP
  end
end
