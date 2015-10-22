require 'rails_helper'

RSpec.describe SettleContestsJob, type: :job do
  it "contests are settled when all games are completed" do
    contest = create(:closed_contest)

    contest_settler = instance_double(Draft::Score)

    allow(Draft::Score).
      to receive(:new).
      with(contest: contest).
      and_return(contest_settler)

    expect(contest_settler).to receive(:settle!)

    SettleContestsJob.new.perform
  end
end
