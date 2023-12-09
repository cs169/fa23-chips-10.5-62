# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  validates :name, presence: true

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each do |official|
      data = extract_rep_data(official, rep_info)
      rep = Representative.find_or_initialize_by(name: official.name)
      rep.update(data)
      reps.push(rep) if rep.persisted?
    end

    reps
  end

  def self.office_info(official, rep_info)
    rep_info.offices.each do |office|
      if office.official_indices.include?(official.index)
        return [office.name, office.division_id]
      end
    end
    ['', '']
  end

  def self.extract_rep_data(official, info)
    title, ocdid = office_info(official, info)
    address = format_address(official.address)

    { name: official.name, ocdid: ocdid, title: title, address: address, party: official.party, photo: official.photo_url }
  end

  def self.format_address(info)
    return '' if info.nil? || info.empty?
    address = info.first
    [address.line1, address.city, address.state, address.zip].join(' ')
  end
end
