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

  describe 'Edit Schedule' do
    let(:schedule) { create(:delivery_schedule) }

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: schedule.id
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        expect(assigns :delivery_schedule).to eq schedule
      end
    end

    describe "PATCH #update" do
      it "returns http success" do
        patch :update, id: schedule.id, delivery_schedule: { date: 2.weeks.from_now }

        expect(response).to redirect_to delivery_schedules_path
        expect(flash[:notice]).to eql("Delivery date has been updated.")
      end

      it 'updates the delivery_schedule' do
        patch :update, id: schedule.id, delivery_schedule: { date: 2.weeks.from_now }

        expect(assigns(:delivery_schedule).reload.date.to_s).to eq 2.weeks.from_now.strftime("%Y-%m-%d")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:schedule) { create(:delivery_schedule) }

    it "destroys a delivery schedule" do
      delete :destroy, id: schedule.id

      expect(DeliverySchedule.where(id: schedule.id)).to be_empty
    end
  end
end
