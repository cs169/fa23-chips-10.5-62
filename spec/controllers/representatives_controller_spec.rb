require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe "GET #show" do
    let(:representative) { create(:representative) } # Adjust as per your factory setup

    it "renders the show template" do
      get :show, params: { id: representative.id }
      expect(response).to render_template(:show)
    end
  end
end
