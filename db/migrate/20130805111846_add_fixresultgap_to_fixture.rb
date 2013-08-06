class AddFixresultgapToFixture < ActiveRecord::Migration
  def change
    add_column :fixtures, :fixresultgap, :integer
  end
end
