require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:email) }

    it { is_expected.to \
         validate_uniqueness_of(:email).
         case_insensitive }
  end

  describe "#guest?" do
    subject { create(:user).guest? }

    it { is_expected.to eq(false) }
  end
end
