class AddNotNullConstraints < ActiveRecord::Migration
  def up
    Item.where(rating: nil).update_all(rating: 1000)

    change_column :comparisons, :result, :integer, null: false
    change_column :comparisons, :item1_id, :integer, null: false
    change_column :comparisons, :item2_id, :integer, null: false
    change_column :items, :name, :string, null: false
    change_column :items, :rating, :integer, null: false, default: 1000
  end
  def down
    change_column :comparisons, :result, :integer, null: true
    change_column :comparisons, :item1_id, :integer, null: true
    change_column :comparisons, :item2_id, :integer, null: true
    change_column :items, :name, :string, null: true
    change_column :items, :rating, :integer, null: true, default: nil
  end
end
