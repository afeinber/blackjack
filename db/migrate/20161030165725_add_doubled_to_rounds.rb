class AddDoubledToRounds < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :doubled, :boolean, default: false
  end
end
