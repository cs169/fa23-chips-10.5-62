# frozen_string_literal: true

require 'rails_helper'

describe State, type: :model do
  describe '#std_fips_code' do
    subject { create(:state, fips_code: fips_code).std_fips_code }

    context 'with a single-digit fips_code' do
      let(:fips_code) { 6 }

      it 'pads the code with a leading zero' do
        is_expected.to eq '06'
      end
    end

    context 'with a two-digit fips_code' do
      let(:fips_code) { 10 }

      it 'returns the code as a string without padding' do
        is_expected.to eq '10'
      end
    end
  end
end