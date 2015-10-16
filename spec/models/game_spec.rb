require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:away_team_id) }

    it { is_expected.to \
         validate_presence_of(:home_team_id) }
  end
end
