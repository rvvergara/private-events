require 'rails_helper'

describe User do
  context "factories" do
    it "has a valid factory" do
      expect(FactoryBot.build(:valid_user)).to be_valid
    end
    it "has an invalid factory" do
      expect(FactoryBot.build(:invalid_user)).to_not be_valid
    end
  end

  context "validations" do
    before :each do
      @user = FactoryBot.build(:valid_user)
    end
    it "is invalid without name" do
      @user.name = nil
      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
    end
    
    it "is invalid without email" do
      @user.email = nil
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end
  end


end