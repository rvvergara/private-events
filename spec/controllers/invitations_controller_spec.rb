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

  describe "PATCH #update" do
    before :each do
      @invitee = FactoryBot.create(:valid_user)
      @event = FactoryBot.create(:future_event)
      @invitation = FactoryBot.create(:new_invitation, event_id: @event.id, invitee_id: @invitee.id)
      
      login(@invitee)

      parameters = {params:{
        id: @invitation.id,
        invitation: {
          invitee_id: @invitee.id,
          event_id: @event.id,
          responded: true,
          accepted: false
        }
      }}
      patch :update, parameters
    end

    it "changes the database" do
      @invitation.reload
      expect(@invitation.responded?).to be(true)
    end

  end

end
