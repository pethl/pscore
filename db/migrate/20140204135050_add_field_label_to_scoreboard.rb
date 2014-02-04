class AddFieldLabelToScoreboard < ActiveRecord::Migration
  def change
    add_column :scoreboards, :label, :string
  end
end
