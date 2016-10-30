class ChangeLostToCompletedOnRounds < ActiveRecord::Migration[5.0]
  def change
    rename_column :rounds, :lost, :completed
  end
end
