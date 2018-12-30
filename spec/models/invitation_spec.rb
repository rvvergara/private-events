require 'rails_helper'

RSpec.describe Invitation do
  
  describe "factories" do
    it "has a valid new_invitation factory" do
      expect(FactoryBot.build(:new_invitation)).to be_valid
    end
  end

  describe "accept instance method" do
    it "sets the invi
    tation's accepted attribute to true" do
      invitation = FactoryBot.create(:new_invitation)

      invitation.accept

      expect(invitation.accepted).to be(true)
    end
  end

end
