class AddCorrectResultToPredict < ActiveRecord::Migration
  def change
    add_column :predicts, :correct_result, :boolean
  end
end
