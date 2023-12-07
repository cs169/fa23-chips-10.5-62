# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
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
