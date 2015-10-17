class CreateDraftPicksForm < Form
  attribute :user
  attribute :contest
  attribute :player

  validates :user,
    presence: true

  validates :contest,
    presence: true

  validates :player,
    presence: true

  validate :user_access
  validate :round_open
  validate :player_available
  validate :salary_cap

  def save
    return if invalid?

    roster.draft_picks.create!(
      player: player,
      cost: player.salary
    )

    true
  end

  private

  def roster
    @_roster ||= contest.rosters.for_user(user).first_or_create!
  end

  def user_access
    if !user_contests.include?(contest)
      errors.add(:base, "User cannot alter this roster")
    end
  end

  def user_contests
    user.contests + user.entered_contests
  end

  def round_open
    unless contest.round_open?
      errors.add(:base, "Player change not available")
    end
  end

  def player_available
    # TODO if postitions of players incorrect

    if !Player.for_round(contest.round).include?(player)
      errors.add(:base, "Player not available")
    elsif player_already_drafted?
      errors.add(:base, "Player already added")
    end
  end

  def player_already_drafted?
    roster.draft_picks.for_player(player).any?
  end

  def salary_cap
    if contest_salary_exceeded?
      errors.add(:base, "Salary cap reached")
    end
  end

  def contest_salary_exceeded?
    player_salaries > contest.salary_cap
  end

  def player_salaries
    roster.draft_picks.sum(:cost) + player.salary
  end
end
