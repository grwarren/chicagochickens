require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    valid_params = { session: { password: "foobar", email: "user@example.com" } }

    post login_path valid_params
  end

end
