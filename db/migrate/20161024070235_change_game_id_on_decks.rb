class ChangeGameIdOnDecks < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :decks, :games
  end
end
