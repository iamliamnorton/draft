class EntriesController < ApplicationController
  before_action :authenticate_user!

  def create
    create_entries_form = CreateEntriesForm.new(
      contest: contest,
      user: current_user
    )

    if create_entries_form.save
      redirect_to contest, notice: 'Contest was successfully entered.'
    else
      notice = create_entries_form.errors.full_messages.first
      redirect_to contest, notice: notice
    end
  end

  private

  def contest
    @contest ||= Contest.find(params[:contest_id])
  end
end
