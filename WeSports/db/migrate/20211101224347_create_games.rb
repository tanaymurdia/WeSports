class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string   :sport_name
      t.string   :address
      t.string   :zipcode
      t.integer  :slots_to_be_filled
      t.datetime :game_start_time
      t.datetime :game_end_time
      t.references :owning_player, foreign_key: { to_table: 'players' }
      t.timestamps
    end
  end
end
