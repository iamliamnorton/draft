require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }
  end
end
