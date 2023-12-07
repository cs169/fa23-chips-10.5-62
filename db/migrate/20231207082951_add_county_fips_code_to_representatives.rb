class AddCountyFipsCodeToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :county_fips_code, :string
  end
end
