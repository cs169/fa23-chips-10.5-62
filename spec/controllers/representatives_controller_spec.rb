require 'rails_helper'



RSpec.describe RepresentativesController, type: :controller do
  describe "GET #index" do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
  describe "POST #create" do
    context 'with valid attributes' do
      it 'creates a new representative' do
        expect {
          post :create, params: { representative: { name: 'New Rep', ocd_id: '163', title: 'Senator' } }
        }.to change(Representative, :count).by(1)
      end

      it 'redirects to the new representative' do
        post :create, params: { representative: { name: 'New Rep', ocd_id: '163', title: 'Senator' } }
        expect(response).to redirect_to(Representative.last)
      end
    end
  end
  # describe "GET #show" do
  # end
  describe "GET #show" do
    it 'assigns the requested representative to @representative' do
      representative = Representative.create(name: 'Willie James', ocd_id: '162', title: 'Governor')
      get :show, params: { id: representative.id }
      expect(assigns(:representative)).to eq(representative)
    end
    it 'renders the show template' do
      representative = Representative.create(name: 'Willie James', ocd_id: '162', title: 'Governor')
      get :show, params: { id: representative.id }
      expect(response).to render_template(:show)
    end
    context 'when the representative does not exist' do
      it 'responds with a 404 not found' do
        get :show, params: { id: 'invalid_id' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
  # describe "GET #show" do
end
