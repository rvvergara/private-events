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

  context "User.digest" do
    it "returns a hashed version of the user password" do
      expect(User.digest("password")).to eq("password")
    end
  end

  context "User.new_token" do
    it "returns a random string" do
      expect(User.new_token).to_not eq(User.new_token)
    end
  end

  context "User.remember_token" do
    it "saves a new remember_digest for the user in the database" do
      user = FactoryBot.build(:valid_user)
      user.remember
      expect(user.remember_digest.nil?).to_not be(true)
    end
  end

end