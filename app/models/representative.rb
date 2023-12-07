# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :destroy

  validates :name, :ocd_id, :title, presence: true

  def self.civic_api_to_representative_params(rep_params)
    rep = find_or_initialize_by(ocd_id: rep_params[:ocd_id])
    rep.assign_attributes(
      name: rep_params[:name],
      title: rep_params[:title],
      party: rep_params[:party],
      contact_info: rep_params[:contact_info]
    )

    rep.save if rep.changed?
    rep
  end
end
