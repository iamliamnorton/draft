class ContestsController < ApplicationController
  before_action :authenticate_user!

  before_action :rounds, only: [:new, :create]

  def show
    @contest = Contest.find(params[:id])
  end

  def new
    @contest = Contest.new(
      round: rounds.first
    )
  end

  def create
    @contest = current_user.contests.new(contest_params)

    if @contest.save
      redirect_to @contest, notice: 'Contest was successfully created.'
    else
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
