class CreatePredicts < ActiveRecord::Migration
  def change
    create_table :predicts do |t|
      t.integer :user_id
      t.integer :homescore
      t.integer :awayscore
      t.integer :points

      t.timestamps
    end
  end
end
