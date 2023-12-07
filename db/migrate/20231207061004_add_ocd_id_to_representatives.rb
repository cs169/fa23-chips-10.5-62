class AddOcdIdToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :ocd_id, :string
  end
end
