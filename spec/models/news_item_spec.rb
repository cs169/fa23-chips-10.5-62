# frozen_string_literal: true

require 'rails_helper'


RSpec.describe NewsItem, type: :model do
  let(:representative) { create(:representative) }

  describe '.find_for' do
    context 'with an existing news item' do
      let!(:news_item) { create(:news_item, representative: representative) }

      it 'returns the news item for the given representative' do
        expect(NewsItem.find_for(representative.id)).to eq(news_item)
      end
    end

    context 'when no news item exists for the representative' do
      it 'returns nil' do
        expect(NewsItem.find_for(-1)).to be_nil
      end
    end
  end

  describe '.all_issues' do
    let(:expected_issues) do
      ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
       'Abortion', 'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change',
       'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality', 'Religious Freedom',
       'Border Security', 'Minimum Wage', 'Equal Pay']
    end

    it 'returns a list of predefined issues' do
      expect(NewsItem.all_issues).to match_array(expected_issues)
    end
  end
end