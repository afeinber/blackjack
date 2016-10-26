class AddRoleToHands < ActiveRecord::Migration[5.0]
  def change
    add_column :hands, :is_dealer, :boolean, null: false, default: false
  end
end
