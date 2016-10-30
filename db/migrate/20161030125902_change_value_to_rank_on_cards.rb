class ChangeValueToRankOnCards < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :value, :rank
  end
end
