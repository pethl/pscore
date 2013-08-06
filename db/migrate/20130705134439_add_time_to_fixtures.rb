class AddTimeToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :ko, :time
  end
end
