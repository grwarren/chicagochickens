require 'rails_helper'

RSpec.describe DeliverySchedulesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:valid_params) { build(:delivery_schedule).attributes }

    it "returns http success" do
      get :create, delivery_schedule: valid_params
      expect(response).to redirect_to delivery_schedules_path
    end

    it 'saves new delivery_schedule' do
      expect {  post :create,  delivery_schedule: valid_params }.to change(DeliverySchedule, :count).by(1)
    end
  end
end
