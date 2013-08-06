class AddMatchscoreToScoreboard < ActiveRecord::Migration
  def change
    add_column :scoreboards, :fixture_id, :integer
    add_column :scoreboards, :user_id, :integer
    add_column :scoreboards, :matchscore, :integer
  end
end
