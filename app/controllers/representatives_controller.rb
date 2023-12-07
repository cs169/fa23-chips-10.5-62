
# frozen_string_literal: true

class RepresentativesController < ApplicationController
  before_action :set_representative, only: %i[:show, :edit, :update, :destroy]

  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
  end

  def new
    @representative = Representative.new
  end

  def edit; end

  def create
    @rep = Representative.new(representative_params)

    if @representative.save
      redirect_to @representative, notice: 'Representative was created successfully.'
    else
      render :new
    end
  end

  def update
    if @representative.update(representative_params)
      redirect_to @representative, notice: 'Representative was updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @representative.destroy
    redirect_to representatives_url, notice: 'Representative was destroyed successfully'
  end

  private

  def set_representative
    @representative = Representative.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to representatives_path, alert: 'Representative not found'
  end

  def representative_params
    params.require(:representative).permit(:name, :ocd_id, :title)
  end
end
