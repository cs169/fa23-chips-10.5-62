# frozen_string_literal: true

class AddColumnsToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :ocdid, :string unless column_exists?(:representatives, :ocdid)
    add_column :representatives, :title, :string unless column_exists?(:representatives, :title)
    add_column :representatives, :address, :string unless column_exists?(:representatives, :address)
    add_column :representatives, :party, :string unless column_exists?(:representatives, :party)
    add_column :representatives, :photo, :string unless column_exists?(:representatives, :photo)
  end
end
