require 'rails_helper'

describe UsersController do

  describe "GET #show" do
    it "gets the user.id from parameters then assign it to @user" do
      user = FactoryBot.create(:valid_user)
      parameters = {params:{id: user.id.to_s}}
      get :show, parameters
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#GET new" do
    it "assigns a new instance of User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #edit" do
    context "logged user tries to edit his/her own profile" do
      before :each do
        @user = User.last
        login(@user)
        get :edit, params: {id: @user.id}
      end

      it "gets params[:id] and determines assigns to @user" do
        get :edit, params: {id: @user.id}
        expect(assigns(:user)).to eq(@user)
      end
  
      it "renders the edit template" do
        expect(response).to render_template("edit")
      end

    end

    context "logged users trying to update another person's profile" do
      before :each do
        @user1 = User.first
        @user2 = User.last
        login(@user1)

        get :edit, params: {id: @user2.id}
      end

      it "should redirect to current_user's own page" do
        expect(response).to redirect_to user_path(@user1)
      end

    end

    context "non logged users" do
      before :each do
        @user = User.last
        parameters = {params: {
          id: @user.id
        }}
        get :edit, parameters
      end

      it "redirects to login_path" do
        expect(response).to redirect_to login_path
      end

      it "shows a flash[:danger] message" do
        expect(flash[:danger]).to match("Please log in first")
      end
    end

  end

  describe "POST #create" do
    context "valid user creation" do
      it "saves user to the database" do
        expect{
          post :create, params: {
            user: FactoryBot.attributes_for(:valid_user)
          }
        }.to change(User, :count).by(1)
      end

      it "logs it the new user" do
        post :create, params: {
          user: FactoryBot.attributes_for(:valid_user)
        }
        expect(current_user).to eq(User.last)
      end

      it "redirects the newly created user to his/her profile page" do
        post :create, params: {
          user: FactoryBot.attributes_for(:valid_user)
        }
        expect(response).to redirect_to(user_path(User.last))
      end

    end

    context "invalid user creation" do
      
      it "re-renders the new template" do
        parameters = {
          params: {user: FactoryBot.attributes_for(:invalid_user)}
        }
        post :create, parameters
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH #update" do
    context "logged user updating his/her own profile" do
      context "valid user update" do
        before :each do
          @user = User.last
          login(@user)
          @parameters = {
            params: {id: @user.id,user: FactoryBot.attributes_for(:valid_user, name: "Hector Calma")} 
          }
          put :update, @parameters
        end
        
        it "shows there is a current_user" do
          expect(current_user).to eq(@user)
        end
  
        it "finds the right user through the params" do
          expect(assigns(:user)).to eq(@user)
        end
  
        it "saves the updated user to the database" do
          @user.reload
          expect(@user.name).to eq("Hector Calma")
        end
  
        it "shows a flash[:success] message" do
          expect(flash[:success]).to match("Your profile is updated")
        end
  
        it "redirects the user back to his/her profile" do
          expect(response).to redirect_to user_path(@user)
        end
      end
  
      context "invalid user update" do
        before :each do
          @name = "Peter"
          @user = FactoryBot.create(:valid_user, name: @name)
          login(@user)
          parameters = {
            params: {
              id: @user.id,
              user: FactoryBot.attributes_for(:valid_user, name: nil)
            }
          }
          patch :update, parameters
        end
  
        it "doesn't save to the database" do
          @user.reload
          expect(@user.name).to eq(@name)
        end
  
        it "re-renders the edit template" do
          expect(response).to render_template("edit")
        end
  
      end
  

    end

    context "logged user trying to update another person's profile" do
      before :each do
        @user1 = User.last
        @user2 = User.first
        @name = "Casper"
        login(@user2)
        parameters = {
          params: {id: @user1.id,user: FactoryBot.attributes_for(:valid_user, name: @name)}
        }
        put :update, parameters
      end

      it "should not save to database" do
        @user1.reload
        expect(@user1.name).to_not eq(@name)
      end

      it "should redirect to current_user's own page" do
        expect(response).to redirect_to(user_path(@user2))
      end
      
    end

    context "non logged user trying to update a profile" do
      before :each do
        @user = User.last
        @name = @user.name
        parameters = {
          params: {
            id: @user.id,
            user: FactoryBot.attributes_for(:valid_user, name: "I was hacked")
          }
        }
        put :update, parameters
      end

      it "should not save to the database" do
        @user.reload
        expect(@user.name).to eq(@name)
      end

      it "should redirect to login path" do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "logged users" do
      before :each do
        @user = User.last
        login(@user)
        delete :destroy, params:{id: @user.id}
      end

      context "user deleted twice" do
        it "should return a flash[:danger] message" do
          delete :destroy, params:{id: @user.id}
          expect(flash[:danger]).to match("User not found")
        end
  
        it "should redirect to root path" do
          expect(response).to redirect_to(root_path)
        end
  
      end

      context "logged authorized users" do
        it "redirects to root path" do
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "non logged users" do
      before :each do
        @user = User.last
        delete :destroy, params:{id: @user.id}
      end
      it "should redirect to log in path" do
        expect(response).to redirect_to(login_path)
      end
    end
             
    context "logged unauthorized users" do
      before :each do
        @user1 = User.first
        @user2 = User.last
        login(@user1)
        delete :destroy, params:{id: @user2.id}
      end
      it "should redirect to current_user's own page" do
        expect(response).to redirect_to(user_path(@user1))
      end
    end

  end

end