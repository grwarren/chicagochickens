require 'rails_helper'

describe UsersController, type: :controller do

  describe 'POST #create' do
    let(:user) { build :user }

    it 'persists a new user' do
      expect { post :create, params: { user: user.attributes } }.to change(User, :count).by(1)
    end

    it "redirects to all users path" do
      post :create, params: { user: user.attributes }

      expect(flash[:notice]).to eql('New User Created')
      expect(response).to redirect_to users_path
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new

      expect(assigns :user).to be_a(User)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #users' do
    let(:users) { create_list :user, 2 }

    it 'returns http success' do
      get :index

      expect(assigns :users).to match_array(users)
      expect(response).to have_http_status(:success)
    end
  end
end
