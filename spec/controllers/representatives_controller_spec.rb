require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe "GET #show" do
    it 'renders the show template' do
      representative = Representative.create(name: 'Willie James')
      get :show, params: { id: representative.id }
      expect(response).to render_template(:show)
    end
  end
end
