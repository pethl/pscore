class AddMoreFieldsToPredicts < ActiveRecord::Migration
  def change
    add_column :predicts, :val_right_result, :integer
    add_column :predicts, :val_closest_to_home, :integer
    add_column :predicts, :val_closest_to_away, :integer
    add_column :predicts, :val_exact_home_score, :integer
    add_column :predicts, :val_exact_away_score, :integer
    add_column :predicts, :val_exact_result, :integer
  end
end
