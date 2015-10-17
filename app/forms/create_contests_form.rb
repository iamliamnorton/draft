class CreateContestsForm < Form
  attribute :user
  attribute :rounds
  attribute :contest

  validates :user,
    presence: true

  validates :rounds,
    presence: true

  validates :contest,
    presence: true

  validates_component :contest

  validate :round_availability_checks,
    if: Proc.new { |form| form.contest.valid? }

  validate :user_credit_checks,
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

  def net_user_credit
    user.credit - (contest.entry * contest.max_entries)
  end

  def round_availability_checks
    unless rounds.include?(contest.round)
      errors.add(:base, "Round not available")
    end
  end

  def user_credit_checks
    if net_user_credit < 0
      errors.add(:base, "Insufficient credit")
    end
  end
end
