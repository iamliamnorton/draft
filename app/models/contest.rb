class Contest < ActiveRecord::Base
  DEFAULT_CAP = 50_000

  belongs_to :user

  has_many :entries

  has_many :contestants,
    class_name: "User",
    through: :entries

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
    where(
      won_at: nil,
      closed_at: nil
    )
  end

  after_initialize do
    self.cap ||= DEFAULT_CAP
  end

  def entries_remaining
    max_entries - entries.count
  end
end
