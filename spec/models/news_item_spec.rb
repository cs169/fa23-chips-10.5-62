# frozen_string_literal: true

require 'rails_helper'

describe NewsItem do
  describe 'when find_for is called' do
    let(:representative) { create(:representative) }

    it 'return the news item, given a representative' do
      news_item = create(:news_item, representative: representative)
      expect(described_class.find_for(representative.id)).to eq(news_item)
    end

    it 'returns nil if no news item exists for the representative' do
      expect(described_class.find_for(-1)).to be_nil
    end
  end

  describe 'when all_issues is called' do
    it 'returns the correct list' do
      issues = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
                'Abortion', 'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change',
                'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality', 'Religious Freedom',
                'Border Security', 'Minimum Wage', 'Equal Pay']
      expect(described_class.all_issues).to match_array(issues)
    end
  end
end