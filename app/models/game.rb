class Game < ActiveRecord::Base
  belongs_to :season

  belongs_to :round

  has_many :contests,
    through: :round

  belongs_to :home_team,
    class_name: "Team"

  belongs_to :away_team,
    class_name: "Team"

  has_many :stats

  def self.by_source(id)
    where(source_id: id).last
  end

  def self.incomplete
    where(completed_at: nil)
  end

  def self.running
    incomplete.
      where('started_at < ?', Time.now)
  end

  def self.include_players
    includes(home_team: [:players], away_team: [:players])
  end

  def completed?
    !!completed_at
  end
end
