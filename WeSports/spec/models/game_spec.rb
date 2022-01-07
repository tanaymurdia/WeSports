require 'rails_helper'
require 'simplecov'

RSpec.describe Game, type: :model do
  before(:all) do
    Game.delete_all
    if Game.where(:sport_name => "Spikeball").empty?
      Game.create(:sport_name => "Spikeball",
                  :zipcode => "10027",
                  :slots_to_be_filled => 4)
    end
    if Game.where(:sport_name => "Basketball").empty?
      Game.create(:sport_name => "Basketball",
                  :zipcode => "10024",
                  :slots_to_be_filled => 10)
    end
    if Game.where(:sport_name => "basketball").empty?
      Game.create(:sport_name => "basketball",
                  :zipcode => "10025",
                  :slots_to_be_filled => 10)
    end
    if Game.where(:sport_name => "Football").empty?
      Game.create(:sport_name => "Football",
                  :zipcode => "10030",
                  :slots_to_be_filled => 22)
    end
    if Game.where(:sport_name => "soccer").empty?
      Game.create(:sport_name => "soccer",
                  :zipcode => "10010",
                  :slots_to_be_filled => 10)
    end
  end

  after(:all) do
    Game.delete_all
  end

  describe "join_game method" do
    it "increments one to the slots_taken" do
      game = Game.find_by(:sport_name => "soccer")
      previous_slots = game.slots_taken
      player = Player.create({:username => 'Joe Shmoe', :email => 'joeshmo@gmail.com'})

      game.player_join_game(player.id)
      expect(game.player_joined_game?(player.id)).to eq(true)
      expect(game.slots_taken).to eq(previous_slots + 1)
    end
  end

  describe "spots_left method" do
    it "calculates the number of available spots left" do
      game = Game.find_by(:sport_name => "soccer")
      player = Player.create({:username => 'Joe Shmoe', :email => 'joeshmo@gmail.com'})
      game.player_join_game(player.id)

      expect(game.spots_left).to eq(9)
    end
  end

  describe "check_game_exists" do
    it "checks if the game exists" do
      game = Game.find_by(:sport_name => "soccer")
      expect(Game.check_game_exist(game.id)[0]).to eq(true)
    end
  end

end