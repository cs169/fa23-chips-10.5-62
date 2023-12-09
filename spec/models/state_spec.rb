# frozen_string_literal: true

require 'rails_helper'

describe State do
  describe '.std_fips_code' do
    let(:state) do
      create(:state, fips_code: fips_code)
    end

    context 'when fips_code is a single digit' do
      let(:fips_code) { 6 }

      it 'returns a zero-padded string' do
        expect(state.std_fips_code).to eq('06')
      end
    end

    context 'when fips_code is two digits' do
      let(:fips_code) { 10 }

      it 'returns the fips_code as a string' do
        expect(state.std_fips_code).to eq('10')
      end
    end
  end
end