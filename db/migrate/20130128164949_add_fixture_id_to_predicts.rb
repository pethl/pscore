class AddFixtureIdToPredicts < ActiveRecord::Migration
  def change
         add_column :predicts, :fixture_id, :integer
  end
end
