require 'rails_helper'
require 'simplecov'

RSpec.describe PlayersController, type: :controller do
  before(:all) do
    Player.delete_all
    players = [{:username => 'Joe Shmoe', :email => 'joeshmo@gmail.com'},
               {:username => 'Random Person', :email => 'rando@columbia.edu'},
               {:username => 'Another Rando', :email => 'rando2@columbia.edu'}
    ]

    players.each do |player|
      p = Player.create!(player)
    end
    @signed_in_player = Player.first


    Game.delete_all
    if Game.where(:sport_name => "Basketball").empty?
      game = Game.create(:sport_name => "Basketball",
                  :zipcode => "10024",
                  :slots_to_be_filled => 10)
      game.owning_player = Player.second
      game.players << Player.first
      game.players << Player.second
      game.save()
    end
    if Game.where(:sport_name => "soccer").empty?
      game = Game.create(:sport_name => "soccer",
                         :zipcode => "10010",
                         :slots_to_be_filled => 10)
      game.owning_player = @signed_in_player
      game.players << Player.first
      game.save()
    end
    end

  after(:all) do
    Game.delete_all
  end

  describe "Navigate to a Profile Page" do
    it "Shows the games created and Games joined" do
      get :show, {:id => @signed_in_player.id}, {:user_id => @signed_in_player.id}
      expect(assigns(:games_created)).to include(Game.find_by(:sport_name=>"soccer"))
      expect(assigns(:games_joined)).to include(Game.find_by(:sport_name=>"soccer"))
      expect(assigns(:games_joined)).to include(Game.find_by(:sport_name=>"Basketball"))
    end

  end
end
