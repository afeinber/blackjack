class AddResultToRounds < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :result, :string
  end
end
