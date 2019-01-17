require 'rails_helper'

describe Event do
  context "factories" do
    it "has a valid future_event factory" do
      expect(FactoryBot.build(:future_event)).to be_valid
    end

    it "has a valid past_event factory" do
      expect(FactoryBot.build(:past_event)).to be_valid
    end
    it "has an invalid_event factory" do
      expect(FactoryBot.build(:invalid_event)).to_not be_valid
    end
  end

  context "validations" do
    before :each do
      @event = FactoryBot.build(:future_event)
    end

    it "is invalid without a title" do
      @event.title = nil
      @event.valid?
      expect(@event.errors[:title]).to include("can't be blank")
    end
    
    it "is invalid without date" do
      @event.date = nil
      @event.valid?
      expect(@event.errors[:date]).to include("can't be blank")
    end

    it "is invalid without venue" do
      @event.venue = nil
      @event.valid?
      expect(@event.errors[:venue]).to include("can't be blank")
    end

    it "is invalid without description" do
      @event.description = nil
      @event.valid?
      expect(@event.errors[:description]).to include("can't be blank")
    end

    it "is valid even without picture" do
      @event.picture = nil
      @event.valid?
      expect(@event.errors[:picture].empty?).to be(true)
    end
  end
end