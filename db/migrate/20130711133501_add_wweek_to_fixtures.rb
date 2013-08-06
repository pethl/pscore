class AddWweekToFixtures < ActiveRecord::Migration
  def change
      add_column :fixtures, :week, :integer
  end
end
