class RenameWinnerColumnOnComparisons < ActiveRecord::Migration
  def change
    rename_column :comparisons, :winner_id, :winning_comparand_id
  end
end
