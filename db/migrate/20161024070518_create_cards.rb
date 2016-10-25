class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :value
      t.references :cardable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
