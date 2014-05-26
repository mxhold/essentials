class MoveComparandsToComparison < ActiveRecord::Migration
  def change
    drop_table :comparands
    remove_column :comparisons, :winning_comparand_id

    add_reference :comparisons, :item1, index: true
    add_reference :comparisons, :item2, index: true
    add_column :comparisons, :result, :integer
  end
end
