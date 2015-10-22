class SettleContestsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Contest.includes(:games).unsettled.each do |contest|
      if contest.games.all?(&:completed?)
        Draft::Score.new(contest: contest).settle!
      end
    end
  end
end
