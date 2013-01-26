class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :games, :name, :string
    add_column :games, :startdate, :datetime
    add_column :games, :enddate, :datetime

  end
end
