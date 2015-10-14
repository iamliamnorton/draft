class ContestsController < ApplicationController
  before_action :authenticate_user!

  before_action :contest, only: [:show, :destroy]

  def show
  end

  def new
    @contest = Contest.new
  end

  def create
    @contest = Contest.new(contest_params)

    entry = current_user.entries.new(
      contest: @contest
    )

    if @contest.save && entry.save!
      redirect_to @contest, notice: 'Contest was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @contest.update!(cancelled_at: Time.now)

    redirect_to lobby_url, notice: 'Contest was successfully cancelled.'
  end

  private

  def contest
    @contest = Contest.find(params[:id])
  end

  def contest_params
    params.require(:contest).permit(:entry)
  end
end
