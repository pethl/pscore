class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.string :content
      t.datetime :matchdate
      t.string :hometeam
      t.string :awayteam
      t.integer :game_id
      t.time  :ko
      t.integer :week
      t.integer :fixresultgap
      t.integer :matchhomescore
      t.integer :matchawayscore

      t.timestamps
    end
    add_index :fixtures, [:game_id, :created_at]
  end
end
