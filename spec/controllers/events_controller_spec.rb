require 'rails_helper'

describe EventsController do
  
  describe "POST #create" do
    
    context "event creator automatically becomes that new event's attendee" do
      
      before :each do
        @user = User.first
        login(@user)
        parameters = {
          params: {
            user_id: @user.id,
            event: FactoryBot.attributes_for(:future_event, creator_id: @user.id)
          }
        }
        post :create, parameters
      end

      it "assigns to @user" do
        expect(assigns(:user)).to eq(@user)
      end

      it "adds user to the new event's attendees" do
        expect(assigns(:event).attendees).to include(@user)
      end

    end

  end

end