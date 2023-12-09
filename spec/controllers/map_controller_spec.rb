require 'rails_helper'

RSpec.describe MapController, type: :controller do
  let(:state) { create(:state, symbol: 'CA') }
  let(:county) { create(:county, state: state, fips_code: 10) }

  describe "GET #index" do
    before { get :index }

    it "assigns all states as @states" do
      expect(assigns(:states)).to eq([state])
    end

    it "assigns states by FIPS code as @states_by_fips_code" do
      expect(assigns(:states_by_fips_code)).to eq({state.std_fips_code => state})
    end
  end

  describe "GET #state" do
    context "when state exists" do
      before { get :state, params: { state_symbol: 'CA' } }

      it "assigns the requested state as @state" do
        expect(assigns(:state)).to eq(state)
      end

      it "assigns county details of the state as @county_details" do
        expect(assigns(:county_details)).to eq(state.counties.index_by(&:std_fips_code))
      end
    end

    context "when state does not exist" do
      it "redirects to the root path" do
        get :state, params: { state_symbol: 'XX' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to match("State 'XX' not found.")
      end
    end
  end

  describe "GET #county" do
    context "when state and county exist" do
      before { get :county, params: { state_symbol: 'CA', std_fips_code: '10' } }

      it "assigns the requested county as @county" do
        expect(assigns(:county)).to eq(county)
      end
    end

    context "when county does not exist" do
      it "redirects to the root path" do
        get :county, params: { state_symbol: 'CA', std_fips_code: '99' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to match(/County with code '99' not found for CA/)
      end
    end
  end
end
