module Draft
  class Score
    SettledContestError = Class.new(StandardError)

    def initialize(contest:)
      @contest = contest
    end

    def settle!
      ensure_valid_contest!

      @contest.contestants.each do |contestant|
	contestant_score = roster_for_contest(contestant).score

	if contestant_score == user_score
	  declare_draw!(contestant)
	else
	  if contestant_score > user_score
	    declare_winner!(contestant)
	  else
	    declare_winner!(@contest.user)
	  end
	end
      end
    end

    private

    def ensure_valid_contest!
      if @contest.settled?
	raise SettledContestError, "Contest has been settled already"
      end
    end

    def declare_draw!(user)
      ActiveRecord::Base.transaction do
	@contest.update!(settled_at: Time.now)

	user.update!(credit: user.credit + @contest.entry)
	@contest.user.update!(credit: @contest.user.credit + @contest.entry)
      end
    end

    def declare_winner!(user)
      ActiveRecord::Base.transaction do
	@contest.update!(settled_at: Time.now)

	user.update!(credit: user.credit + @contest.prize)
      end
    end

    def user_score
      @_user_score ||= roster_for_contest(@contest.user).score
    end

    def roster_for_contest(user)
      Roster.where(contest: @contest, user: user).first
    end
  end
end
