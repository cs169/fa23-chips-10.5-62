# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe 'when a representative already exists in the database' do
    let(:existing_rep) do
      described_class.create!(name: 'Bruh Bro', ocdid: 'ocd-id', title: 'President')
    end

    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'Bruh Bro')],
        offices:   [OpenStruct.new(name: 'President', division_id: 'ocd-id', official_indices: [0])]
      )
    end

    it 'does not create a duplicate one' do
      existing_rep
      expect { described_class.civic_api_to_representative_params(rep_info) }.not_to change(described_class, :count)
    end
  end
  describe 'associations' do
    it { is_expected.to have_many(:related_model) }
    it { is_expected.to have_many(:news_items).dependent(:destroy) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:ocd_id) }
  end
  describe '.active_representatives' do  # Assuming a scope named 'active_representatives'
    it 'returns only active representatives' do
      active_rep = create(:representative, active: true)
      inactive_rep = create(:representative, active: false)
  
      expect(Representative.active_representatives).to include(active_rep)
      expect(Representative.active_representatives).not_to include(inactive_rep)
    end
  end

  describe '.civic_api_to_representative_params' do
    context 'when representative exists' do
      let!(:existing_rep) { described_class.create(ocd_id: '162', name: 'Evan Sukhpal', title: 'Senator') }

      it 'updates existing representative' do
        params = { ocd_id: '162', name: 'Jane Doe', title: 'Senator' }

        representative = described_class.civic_api_to_representative_params(params)
        expect(representative.id).to eq existing_rep.id
        expect(representative.name).to eq 'Jane Doe'
        expect(described_class.count).to eq 1
      end

      it 'updates specified fields' do
        params = { ocd_id: '162', title: 'Governor' }

        representative = described_class.civic_api_to_representative_params(params)
        expect(representative.title).to eq 'Governor'
        expect(representative.name).to eq 'Evan Sukhpal'
      end
    end

    context 'when representative d oes not exist' do
      it 'creates new representative' do
        params = { ocd_id: '261', name: 'Laksith James', title: 'Congressman' }
        expect { described_class.civic_api_to_representative_params(params) }.to change(described_class, :count).by(1)
      end
    end

    context 'with invalid data' do
      it 'does not create a rep with invalid data' do
        invalid_params = { ocd_id: '', name: '', title: '' }
        expect do
          described_class.civic_api_to_representative_params(invalid_params)
        end.not_to change(described_class, :count)
      end
    end
  end
end
