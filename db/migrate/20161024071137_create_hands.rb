class CreateHands < ActiveRecord::Migration[5.0]
  def change
    create_table :hands do |t|
      t.references :rounds, index: true
      t.timestamps
    end
    binding.pry
    execute("SELECT setval('hands_id_seq', 1000);")
  end
end
