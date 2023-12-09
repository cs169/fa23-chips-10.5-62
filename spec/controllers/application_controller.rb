# spec/controllers/application_controller_spec.rb
require 'rails_helper'

class Controller < ApplicationController
  def index; end
end

describe Controller, type: :controller do
  before do
    routes.draw { get 'index' => 'dummy#index' }
  end

  context 'when user is authenticated' do
    before do
      session[:current_user_id] = 1
      get :index
    end

    it 'sets @authenticated to true' do
      expect(assigns(:authenticated)).to be true
    end
  end

  context 'when user is not authenticated' do
    before do
      session[:current_user_id] = nil
      get :index
    end

    it 'sets @authenticated to false' do
      expect(assigns(:authenticated)).to be false
    end
  end
end
