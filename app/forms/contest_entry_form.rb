class ContestEntryForm < Form
  attribute :user
  attribute :contest

  validates :user,
    presence: true

  validates :contest,
    presence: true

  validate :contest_availability_checks
  validate :user_credit_checks

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      contest.entries.create!(user: user)

      user.update!(credit: net_user_credit)
    end

    true
  end

  private

  def net_user_credit
    user.credit - contest.entry
  end

  def contest_availability_checks
    if user.contests.include?(contest)
      errors.add(:base, "Cannot enter own contest")
    elsif user.entered_contests.include?(contest)
      errors.add(:base, "Cannot enter contest more than once")
    elsif contest.entries.count >= contest.max_entries
      errors.add(:base, "Contest maximum entries reached")
    end
  end

  def user_credit_checks
    if net_user_credit < 0
      errors.add(:base, "Insufficient credit")
    end
  end
end
