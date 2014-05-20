class CreateComparands < ActiveRecord::Migration
  def change
    create_table :comparands do |t|
      t.references :comparison, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
