class RemoveBalanceFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :balance
  end
end
