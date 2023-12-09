# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
    # Testing Validations
    describe 'validations' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
    end
  
    # Testing Instance Methods
    describe '#name' do
      let(:user) { create(:user, first_name: 'John', last_name: 'Doe') }
  
      it 'returns the full name of the user' do
        expect(user.name).to eq 'John Doe'
      end
    end
  
    describe '#auth_provider' do
      context 'when provider is google_oauth2' do
        let(:google_user) { create(:user, provider: :google_oauth2) }
  
        it 'returns Google' do
          expect(google_user.auth_provider).to eq 'Google'
        end
      end
  
      context 'when provider is github' do
        let(:github_user) { create(:user, provider: :github) }
  
        it 'returns Github' do
          expect(github_user.auth_provider).to eq 'Github'
        end
      end
    end
  
    # Testing Class Methods
    describe '.find_google_user' do
      let(:google_user) { create(:user, provider: :google_oauth2, uid: '12345') }
  
      it 'finds a Google user by uid' do
        expect(User.find_google_user('12345')).to eq google_user
      end
  
      it 'returns nil if the user is not found' do
        expect(User.find_google_user('non_existent_uid')).to be_nil
      end
    end
  
    describe '.find_github_user' do
      let(:github_user) { create(:user, provider: :github, uid: '54321') }
  
      it 'finds a Github user by uid' do
        expect(User.find_github_user('54321')).to eq github_user
      end
  
      it 'returns nil if the user is not found' do
        expect(User.find_github_user('non_existent_uid')).to be_nil
      end
    end
  end