class ContestsController < ApplicationController
  before_action :authenticate_user!

  before_action :rounds, only: [:new, :create]

  def show
    @contest = Contest.includes(round: [:games]).find(params[:id])

    @draft_picks = @contest.
      rosters.
      for_user(current_user).
      first_or_initialize.
      draft_picks.
      order(cost: :desc)

    @players = Player.for_round(@contest.round).where.not(
      id: @draft_picks.pluck(:player_id)
    ).order(salary: :desc)
  end

  def new
    @contest = Contest.new(
      round: rounds.first
    )
  end

  def create
    @contest = current_user.contests.new(contest_params)

    create_contests_form = CreateContestsForm.new(
      contest: @contest,
      user: current_user
    )

    if create_contests_form.save
      redirect_to @contest, notice: 'Contest was successfully created.'
    else
      flash[:notice] = create_contests_form.errors.full_messages.first
      render :new
    end
  end

  private

  def rounds
    @rounds ||= Round.open
  end

  def contest_params
    params.require(:contest).permit(:entry, :round_id, :max_entries)
  end
end
