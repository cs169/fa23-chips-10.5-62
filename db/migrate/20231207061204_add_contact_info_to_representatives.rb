class AddContactInfoToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :contact_info, :string
  end
end
