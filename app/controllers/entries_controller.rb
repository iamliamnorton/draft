class EntriesController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.can_enter?(contest)
      contest.entries.create!(user: current_user)
      flash[:notice] = 'Contest was successfully joined.'
    else
      flash[:notice] = 'Contest cannot be joined.'
    end

    redirect_to contest
  end

  private

  def contest
    @contest ||= Contest.find(params[:contest_id])
  end
end
