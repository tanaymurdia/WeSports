class CreateJoinTableGamePlayer < ActiveRecord::Migration
  def change
    create_join_table :games, :players, id: false do |t|
      # t.index [:game_id, :player_id]
      # t.index [:player_id, :game_id]
    end
  end
end
