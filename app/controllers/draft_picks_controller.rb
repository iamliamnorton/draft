class DraftPicksController < ApplicationController
  before_action :authenticate_user!

  def create
    player = Player.find(params[:player_id])

    create_draft_picks_form = CreateDraftPicksForm.new(
      player: player,
      contest: contest,
      user: current_user
    )

    if create_draft_picks_form.save
      redirect_to contest, notice: 'Player added to roster.'
    else
      notice = create_draft_picks_form.errors.full_messages.first
      redirect_to contest, notice: notice
    end
  end

  def destroy
    roster = contest.
      rosters.
      for_user(current_user).
      first

    if roster && draft_pick = roster.draft_picks.find(params[:id])
      draft_pick.destroy
      flash[:notice] = 'Player removed from roster.'
    end

    redirect_to contest
  end

  private

  def contest
    @contest ||= Contest.find(params[:contest_id])
  end
end
