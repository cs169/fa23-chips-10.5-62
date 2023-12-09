# frozen_string_literal: true

require 'rails_helper'

describe Representative do
  describe 'when a representative already exists in the database' do
    let(:existing_rep) do
      described_class.create!(name: 'James Sukh', ocdid: 'ocd-id', title: 'President')
    end
    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'James Sukh')],
        offices:   [OpenStruct.new(name: 'President', division_id: 'ocd-id', official_indices: [0])]
      )
    end
    it 'does not create a duplicate one' do
      existing_rep
      expect { described_class.civic_api_to_representative_params(rep_info) }.not_to change(described_class, :count)
    end
  end
end