class AddGameIdToPredicts < ActiveRecord::Migration
  def change
     add_column :predicts, :game_id, :integer
  end
end
