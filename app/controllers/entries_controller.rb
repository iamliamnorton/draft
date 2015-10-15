class EntriesController < ApplicationController
  before_action :authenticate_user!

  def create
    contest_entry = ContestEntryForm.new(
      contest: contest,
      user: current_user
    )

    if contest_entry.valid? && contest_entry.save
      redirect_to contest, notice: 'Contest was successfully entered.'
    else
      flash[:notice] = contest_entry.errors.full_messages.first
      render 'contests/show'
    end
  end

  private

  def contest
    @contest ||= Contest.find(params[:contest_id])
  end
end
