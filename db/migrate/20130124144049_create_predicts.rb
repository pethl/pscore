class CreatePredicts < ActiveRecord::Migration
  def change
    create_table :predicts do |t|
      t.integer :user_id
      t.integer :homescore
      t.integer :awayscore
      t.integer :points
      t.integer :val_right_result
      t.integer :val_closest_to_home
      t.integer :val_closest_to_away
      t.integer :val_exact_result
      t.integer :game_id
      t.integer :right_result
      t.integer :closest_to_home
      t.integer :closest_to_away
      t.integer :exact_home_score
      t.integer :exact_away_score
      t.integer :exact_result
      t.integer :nearest_margin
      t.integer :fixture_id
      
      t.timestamps
    end
  end
end
