# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    if params[:county_fips]
      @representatives = Representative.where(county_fips_code: params[:county_fips])
    else
      address = params[:address]
      service = Google::Apis::CivicinfoV2::CivicInfoService.new
      service.key = Rails.application.credentials[:GOOGLE_API_KEY]
      result = service.representative_info_by_address(address: address)
      @representatives = Representative.civic_api_to_representative_params(result)
    end

    render 'representatives/search'
  end
end
