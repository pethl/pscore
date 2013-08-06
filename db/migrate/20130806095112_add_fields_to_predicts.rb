class AddFieldsToPredicts < ActiveRecord::Migration
  def change
    add_column :predicts, :right_result, :integer
    add_column :predicts, :closest_to_home, :integer
    add_column :predicts, :closest_to_away, :integer
    add_column :predicts, :exact_home_score, :integer
    add_column :predicts, :exact_away_score, :integer
    add_column :predicts, :exact_result, :integer
  end
end
