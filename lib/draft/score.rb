module Draft
  class Score
    SettledContestError = Class.new(ArgumentError)
    UnfinishedGamesError = Class.new(ArgumentError)

    def initialize(contest:)
      @contest = contest
    end

    def settle!
      raise SettledContestError if @contest.settled?
      raise UnfinishedGamesError unless @contest.games.all?(&:completed?)

      refund! if @contest.contestants.none?

      user_score = roster_for_contest(@contest.user).
        first_or_initialize.
        score

      @contest.contestants.each do |contestant|
        contestant_score = roster_for_contest(contestant).
          first_or_initialize.
          score

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

    def declare_draw!(contestant)
      ActiveRecord::Base.transaction do
	@contest.update!(settled_at: Time.now)

        [contestant, @contest.user].each do |user|
          user.update!(credit: user.credit + @contest.entry)
        end
      end
    end

    def declare_winner!(user)
      ActiveRecord::Base.transaction do
	@contest.update!(settled_at: Time.now)

	user.update!(credit: user.credit + @contest.prize)
      end
    end

    def refund!
      ActiveRecord::Base.transaction do
	@contest.update!(settled_at: Time.now)

        refund_amount = @contest.entry * @contest.max_entries
        @contest.user.update!(credit: @contest.user.credit + refund_amount)
      end
    end

    def roster_for_contest(user)
      Roster.where(contest: @contest, user: user)
    end
  end
end
