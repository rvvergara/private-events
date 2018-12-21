require 'rails_helper'

RSpec.describe UsersInviteController do

  describe "GET #show" do
    context "event creator" do
      before :each do
        @creator = User.first
        @event = FactoryBot.create(:future_event, creator_id: @creator.id)
        login(@creator)
        get :show, params: {creator_id: @creator.id, event_id: @event.id}
      end
      
      it "assigns the chosen event to @event" do
        expect(assigns(:event)).to eq(@event)
      end
  
      it "generates a list of users" do
        expect(assigns(:users)).to match_array(User.all)
      end
    end
    
    context "not the event creator" do
      before :each do
        @creator = User.first
        @visitor = User.last
        @event = FactoryBot.create(:future_event, creator_id: @creator.id)
        login(@visitor)
        get :show, params: {creator_id: @creator.id, event_id: @event.id}
      end

      it "redirects to the visitor's own page" do
        expect(response).to redirect_to(user_path(@visitor))
      end

      it "shows a flash[:danger]" do
        expect(flash[:danger]).to match("You are not authorized to do that!")
      end

    end

  end

end
