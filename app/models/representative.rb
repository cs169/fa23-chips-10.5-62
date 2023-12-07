# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  attribute :street, :string
  attribute :city, :string
  attribute :state, :string
  attribute :zip, :string
  attribute :party, :string
  attribute :photo, :string

  validates :name, :ocd_id, :title, presence: true

  def self.civic_api_to_representative_params(rep_params)
    rep = find_or_initialize_by(ocd_id: rep_params[:ocd_id])

    rep.name = rep_params[:name] if rep_params.has_key?(:name)
    rep.title = rep_params[:title] if rep_params.has_key?(:title)
    rep.party = rep_params[:party] if rep_params.has_key?(:party)
    rep.contact_info = rep_params[:contact_info] if rep_params.has_key?(:contact_info)

    rep.save if rep.changed?

    rep
  end
end
