class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|

      t.timestamps
      t.integer :game_id, null: false
    end
  end
end
