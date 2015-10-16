require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it { is_expected.to \
         validate_presence_of(:position) }

    it { is_expected.to \
         validate_presence_of(:salary) }
  end
end
