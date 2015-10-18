class CreateContestsForm < Form
  attribute :user
  attribute :rounds
  attribute :contest

  validates :user,
    presence: true

  validates :contest,
    presence: true

  validates_component :contest

  validate :round_open,
    if: Proc.new { |form| form.contest.valid? }

  validate :user_credit,
    if: Proc.new { |form| form.contest.valid? }

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      contest.save!

      user.update!(credit: net_user_credit)
    end

    true
  end

  private

  def round_open
    unless open_rounds.include?(contest.round)
      errors.add(:base, "Round not available")
    end
  end

  def open_rounds
    Round.open
  end

  def user_credit
    if net_user_credit < 0
      errors.add(:base, "Insufficient credit")
    end
  end

  def net_user_credit
    user.credit - (contest.entry * contest.max_entries)
  end
end
