require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe "GET #login" do
    context "when user is already logged in" do
      before do
        session[:current_user_id] = create(:user).id
        get :login
      end

      it "redirects to the user profile" do
        expect(response).to redirect_to(user_profile_path)
        expect(flash[:notice]).to match(/already logged in/)
      end
    end

    context "when user is not logged in" do
      it "renders the login template" do
        get :login
        expect(response).to render_template(:login)
      end
    end
  end

  describe "GET #google_oauth2" do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      get :google_oauth2
    end

    it "creates a new session for the user" do
      expect(session[:current_user_id]).not_to be_nil
    end

    it "redirects to the destination or root path" do
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #github" do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
      get :github
    end

    it "creates a new session for the user" do
      expect(session[:current_user_id]).not_to be_nil
    end

    it "redirects to the destination or root path" do
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #logout" do
    before do
      session[:current_user_id] = create(:user).id
      get :logout
    end

    it "clears the session" do
      expect(session[:current_user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end
end
