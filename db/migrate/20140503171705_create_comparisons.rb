class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.references :winner, index: true

      t.timestamps
    end
  end
end
