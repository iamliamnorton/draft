require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it { is_expected.to \
         validate_uniqueness_of(:name).
         scoped_to(:sport_id) }
  end
end
