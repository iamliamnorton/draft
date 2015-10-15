class ContestsController < ApplicationController
  before_action :authenticate_user!

  def show
    @contest = Contest.find(params[:id])
  end

  def new
    @contest = Contest.new
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

  def contest_params
    params.require(:contest).permit(:entry, :max_entries)
  end
end
