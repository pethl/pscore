class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
        t.string :name
        t.date :startdate
        t.date :enddate
      t.timestamps
    end
  end
end
