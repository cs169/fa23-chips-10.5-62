# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])

    
    @name = @representative.name
    @title = @representative.title
    @ocd_id = @representative.ocd_id
    @party = @representative.party
    @photo = @representative.photo

    render 'representatives/show'
  end
end
