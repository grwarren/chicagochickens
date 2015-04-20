require 'rails_helper'

describe UsersController, type: :controller do

  describe "POST #create" do
    let(:user) { build :user }

    it "redirects to all users path" do
      post :create, user: user.attributes

      expect(response).to redirect_to new_user_path
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new

      expect(assigns :user).to be_a(User)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    before(:each) do
      @users = create_list :user, 2
    end

    it "returns http success" do
      get :index

      expect(assigns :users).to match_array(@users)
      expect(response).to have_http_status(:success)
    end
  end
end
