require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe "#email" do
    subject { described_class.new.email }

    it { is_expected.to eq("") }
  end

  describe "#credit" do
    subject { described_class.new.credit }

    it { is_expected.to eq(0) }
  end

  describe "#guest?" do
    subject { described_class.new.guest? }

    it { is_expected.to eq(true) }
  end

  describe "#admin" do
    subject { described_class.new.admin }

    it { is_expected.to eq(false) }
  end
end
