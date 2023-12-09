# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #index' do
    let!(:representatives) do
      [
        Representative.create(name: 'Evan', ocdid: '1', title: 'Govenor'),
        Representative.create(name: 'Sukhpal', ocdid: '2', title: 'Senator'),
        Representative.create(name: 'James', ocdid: '3', title: 'Chief')
      ]
    end

    before { get :index }

    it 'loads reps into @representatives' do
      expect(assigns(:representatives)).to match_array(representatives)
    end

    it 'renders index view' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    let(:representative) do
      Representative.create(
        name:    'Sukhpal Evan',
        ocdid:   '3',
        title:   'Representative',
        address: '23 Hello St',
        party:   'Labor',
        photo:   'photo.jpg'
      )
    end

    before { get :show, params: { id: representative.id } }

    it 'assigns the requested representative as @representative' do
      expect(assigns(:representative)).to eq(representative)
    end

    it 'verifies attributes' do
      expect(assigns(:name)).to eq('Sukhpal Evan')
      expect(assigns(:ocdid)).to eq('3')
      expect(assigns(:title)).to eq('Representative')
      expect(assigns(:address)).to eq('23 Hello St')
      expect(assigns(:party)).to eq('Labor')
      expect(assigns(:photo)).to eq('photo.jpg')
    end

    it 'renders show view' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template('show')
    end
  end
end
