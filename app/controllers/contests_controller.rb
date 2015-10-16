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

    contest_creation_form = ContestCreationForm.new(
      contest: @contest,
      user: current_user,
      rounds: rounds
    )

    if contest_creation_form.valid? && contest_creation_form.save
      redirect_to @contest, notice: 'Contest was successfully created.'
    else
      flash[:notice] = contest_creation_form.errors.full_messages.first
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
