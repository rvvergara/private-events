require 'rails_helper'

RSpec.describe InvitationsController do

  describe "POST #create" do
    
    it "saves to the database" do
      event = FactoryBot.create(:future_event)
      login(event.creator)
      expect{
        post :create, params:{creator_id: event.creator.id,
          invitation: FactoryBot.attributes_for(:new_invitation, event_id: event.id)
        }
      }.to change(Invitation, :count).by(1)
    end

    context "instance variables assignment and redirection" do
      before :each do
        @event = FactoryBot.create(:future_event)
        
        login(@event.creator)
        
        parameters = {
          params: {creator_id: @event.creator.id, invitation: FactoryBot.attributes_for(:new_invitation, event_id: @event.id)}
        }
        post :create, parameters
      end

      it "assigns to @event" do
        expect(assigns(:event)).to eq(@event)
      end

      it "assigns to @creator" do
        expect(assigns(:creator)).to eq(@event.creator)
      end

      it "redirects to add_invitees path after invitation creation" do
        expect(response).to redirect_to(add_invitees_path(@event.creator, @event))
      end

    end

  end

end
