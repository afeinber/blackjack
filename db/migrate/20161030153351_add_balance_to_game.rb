class AddBalanceToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :balance, :integer
  end
end
