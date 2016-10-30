class AddLostToRounds < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :lost, :boolean, default: false
  end
end
