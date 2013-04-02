class AddMatchhomescoreToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :matchhomescore, :integer
    add_column :fixtures, :matchawayscore, :integer

  end
end
