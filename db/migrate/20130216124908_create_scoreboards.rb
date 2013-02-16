class CreateScoreboards < ActiveRecord::Migration
  def change
    create_table :scoreboards do |t|
      t.integer :week
      t.integer :game_id
      t.integer :position
      t.text :comment

      t.timestamps
    end
  end
end
