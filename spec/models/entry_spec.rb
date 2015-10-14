require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:contest) }

    it { is_expected.to \
         validate_presence_of(:user) }
  end
end
