require 'rails_helper'

RSpec.describe Invitation do
  
  describe "factories" do
    it "has a valid new_invitation factory" do
      expect(FactoryBot.build(:new_invitation)).to be_valid
    end
  end

  describe "accept instance method" do
    it "sets the invitation's accepted attribute to true" do
      invitation = FactoryBot.create(:new_invitation)

      invitation.accept

      expect(invitation.accepted).to be(true)
    end
  end

  describe "decline instance method" do
    it "sets the invitation's declined attribute to true" do
      invitation = FactoryBot.create(:new_invitation)

      invitation.decline

      expect(invitation.declined).to be(true)
    end
  end

end
