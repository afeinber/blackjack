class ChangeBetOnRounds < ActiveRecord::Migration[5.0]
  def change
    change_column_null :rounds, :bet, :false
    change_column_default :rounds, :bet, 0
  end
end
