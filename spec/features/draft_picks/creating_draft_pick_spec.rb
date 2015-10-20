require 'rails_helper'

RSpec.describe "Creating draft pick", type: :feature do
  let!(:contest) { create(:contest) }
  let!(:game) { create(:game, round: contest.round) }
  let!(:player) { create(:player, team: game.home_team) }

  it "user can add and remove players" do
    user = contest.user

    sign_in(user)

    visit contest_path(contest)

    click_link 'Add'
    expect(page).to have_content "Player added to roster."

    click_link 'Remove'
    expect(page).to have_content "Player removed from roster."
  end

  it "contestant can add and remove players" do
    user = create(:entry, contest: contest).user

    sign_in(user)

    visit contest_path(contest)

    click_link 'Add'
    expect(page).to have_content "Player added to roster."

    click_link 'Remove'
    expect(page).to have_content "Player removed from roster."
  end
end
