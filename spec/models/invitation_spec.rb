require 'rails_helper'

RSpec.describe Invitation do
  describe "factories" do
    it "has a valid new_invitation factory" do
      expect(FactoryBot.build(:new_invitation)).to be_valid
    end
  end
end
