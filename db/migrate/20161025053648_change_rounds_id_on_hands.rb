class ChangeRoundsIdOnHands < ActiveRecord::Migration[5.0]
  def change
    remove_reference :hands, :rounds, index: true
    add_reference :hands, :round, index: true
  end
end
