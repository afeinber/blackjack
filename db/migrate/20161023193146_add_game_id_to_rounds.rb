class AddGameIdToRounds < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :game_id, :integer
    add_foreign_key :rounds, :games
  end
end
