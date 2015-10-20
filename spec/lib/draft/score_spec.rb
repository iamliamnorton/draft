require 'rails_helper'

RSpec.describe Draft::Score, type: :model do
  let(:contest) { create(:contest) }

  describe "#settle!" do # TODO
    it "raises an exception for a settled contest" do
    end

    it "adds credit to the winners account" do
    end

    it "sets the contests settled_at" do
    end

    context "when a draw occurs" do
      it "adds credit to the users account" do
      end

      it "adds credit to the contestants account" do
      end

      it "sets the contests settled_at" do
      end
    end
  end
end
