require 'rails_helper'
require 'simplecov'

RSpec.describe GamesController, type: :controller do
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
    if Game.where(:sport_name => "Spikeball").empty?
      Game.create(:sport_name => "Spikeball",
                  :zipcode => "10027",
                  :slots_to_be_filled => 2)
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
      game = Game.create(:sport_name => "soccer",
                  :zipcode => "10010",
                  :slots_to_be_filled => 10)
      game.owning_player = @signed_in_player
      game.save()
    end
  end

  after(:all) do
    Game.delete_all
  end

  describe "When trying to filter by name with a valid sport name" do
    it "returns a valid list of games filtered by that sport name" do
      get  :index,{:name_search => "Basketball"}, {:name_search => "Basketball", :user_id => @signed_in_player.id}

      expect(assigns(:games).length).not_to eq(0)

      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"basketball"))

      expect(assigns(:games)).not_to include(Game.find_by(:sport_name=>"soccer"))
      expect(assigns(:games)).not_to include(Game.find_by(:sport_name=>"Football"))

    end

  end

  describe "When trying to filter by name with an empty sport name" do
    it "returns the list of all games" do
      get  :index, {:name_search => ""}, {:name_search => "", :user_id => @signed_in_player.id}

      expect(assigns(:games).length).to eq(5)

      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Spikeball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Football"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"soccer"))

    end

  end

  describe "When trying to filter by name with an invalid sport name" do
    it "returns an empty list of games" do
      get  :index, {:name_search => "invalid"}, {:name_search => "invalid", :user_id => @signed_in_player.id}

      expect(assigns(:games).length).to eq(0)
    end
  end

  describe "When the only available button is not checked" do
    it "Shows the entire list of games" do
      game = Game.where(:sport_name => "Spikeball").first
      game.players << [Player.second, Player.third]

      get  :index, {:only_available => "0"}, {:only_available => "1", :user_id => @signed_in_player.id}

      expect(assigns(:games).length).to eq(5)

      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Spikeball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Football"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"soccer"))

    end
  end

  describe "When the only available button is checked" do
    it "Shows the entire list of games" do
      game = Game.where(:sport_name => "Spikeball").first
      game.players << [Player.second, Player.third]

      get  :index, {:only_available => "1"}, {:only_available => "1", :user_id => @signed_in_player.id}

      expect(assigns(:games).length).to eq(4)

      expect(assigns(:games)).not_to include(Game.find_by(:sport_name=>"Spikeball"))

    end
  end



  describe "When trying to filter by zipcode" do
    it "returns a valid list of games filtered by that zipcode" do
      get :index, {:zip_search => "10010"}, {:zip_search => "10010", :user_id => @signed_in_player.id}
      expect(assigns(:games).length).to eq(1)
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"soccer"))
    end
  end

  describe "When trying to filter by blank zipcode" do
    it "returns a valid list of games filtered by that zipcode" do
      get :index, {:zip_search => ""}, {:zip_search => "", :user_id => @signed_in_player.id}
      expect(assigns(:games).length).to eq(5)
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"basketball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Spikeball"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Football"))
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"soccer"))
    end
  end

  describe "When trying to filter by invalid zipcode" do
    it "returns a valid list of games filtered by that zipcode" do
      get  :index, {:zip_search => "abc"}, {:zip_search => "abc", :user_id => @signed_in_player.id}
      expect(assigns(:games).length).to eq(0)
      expect(assigns(:games)).not_to include(Game.find_by(:sport_name=>"soccer"))
    end
  end

  describe "When trying to filter by zip code and sport name" do
    it "returns a list of games with sport name equal to the sport name search and with same zip code" do
      get  :index, {:name_search => "Basketball", :zip_search => "10025"}, {:name_search => "Basketball", :zip_search => "10025", :user_id => @signed_in_player.id}
      expect(assigns(:games).length).to eq(1)

      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"basketball"))

      expect(assigns(:games)).not_to include(Game.find_by(:sport_name=>"basketball", :zipcode => "10024"))

    end
  end

  describe "When trying to filter by sport name, zipcode and only available" do
    it "returns a valid list of games filtered by that zipcode" do
      get  :index, {:zip_search => "10024", :only_available => "0", :name_search=>"Basketball"}, {:zip_search => "10024", :only_available => "0", :name_search=>"Basketball", :user_id => @signed_in_player.id}
      expect(assigns(:games).length).to eq(1)
      expect(assigns(:games)).to include(Game.find_by(:sport_name=>"Basketball"))
    end
  end

  describe "When trying to sort by Sport Name" do
    it "returns a list of games sorted asc" do
      get  :index, {:sort => 'name'}, {:user_id => @signed_in_player.id, :sort => 'name'}
      expect(assigns(:games).map { |game| game.sport_name }).to eq(["Basketball", "Football", "Spikeball", "basketball", "soccer"])
    end
  end

  describe "When trying to sort by Start Time" do
    it "returns a list of games sorted asc" do
      get  :index, {:sort => 'start'}, {:user_id => @signed_in_player.id, :sort => 'start'}
      expect(assigns(:games).map { |game| game.sport_name }).to eq(["Spikeball", "Basketball", "basketball", "Football", "soccer"])
    end
  end

  describe "Add New Game" do
    it "with valid parameters" do
      previous_len = Game.all().count
      get :create, {:game => {:sport_name => "Wiffle Ball",
                                        :zipcode => "10027",
                                        :slots_to_be_filled => 20}}, {:user_id => @signed_in_player.id}
      expect(response).to redirect_to games_path
      expect(flash[:notice]).to match(/Successfully created Wiffle Ball game/)
      expect(Game.all().count).to eq(previous_len + 1)
      Game.find_by(:sport_name => "Wiffle Ball").destroy
    end

    it "Game with no name or zipcode parameters" do
      get :create, {:game => {:sport_name => "",
                                        :zipcode => "10027",
                                        :slots_to_be_filled => 20}}
      expect(response).to redirect_to new_game_path
      expect(flash[:notice]).to match(/Error: Missing Zip Code or Sport Name Fields/)
    end

    it "Game with no available slots" do
      get :create, {:game => {:sport_name => "Soccer",
                                        :zipcode => "10027",
                                        :slots_to_be_filled => ""
                                        }}
      expect(response).to redirect_to new_game_path
      expect(flash[:notice]).to match(/Error: Total Slots Available not valid/)
    end
  end

  describe "Update existing game" do
    it "Successfully edits the name" do
      game = Game.create!(:sport_name => "Football",
                         :zipcode => "10026",
                         :slots_to_be_filled => 20)
      game.owning_player = @signed_in_player
      game.save()

      get :update, {:id => game.id, :game =>
        {:sport_name => "New Sport", :zipcode => "10026",
         :slots_to_be_filled => 20} }, {:user_id => @signed_in_player.id}

      expect(response).to redirect_to game_path(game)
      expect(flash[:notice]).to match(/Successfully updated game/)
    end

    it "Doesn't include zipcode or name" do
      game = Game.create(:sport_name => "New Sport",
                         :zipcode => "10026",
                         :slots_to_be_filled => 20)
      game.owning_player = @signed_in_player
      game.save()

      get :update, {:id => game.id, :game =>
        {:sport_name => "", :zipcode => "10026",
         :slots_to_be_filled => 20} }, {:user_id => @signed_in_player.id}

      expect(response).to redirect_to edit_game_path(game)
      expect(flash[:notice]).to match(/Error: Missing Zip Code or Sport Name Fields/)
    end

    it "Fewer Total Slots than slots taken" do
      game = Game.where(:sport_name => "Spikeball").first
      game.owning_player = @signed_in_player
      game.save()

      game.players << [Player.second, Player.third]

      put :update, {:id => game.id, :game =>
        {:slots_to_be_filled => 1, :zipcode => "10026",
         :sport_name => "New Sport"} }, {:user_id => @signed_in_player.id}

      expect(response).to redirect_to edit_game_path(game)
      expect(flash[:notice]).to match("Error: More Slots Taken (2) than Available")
      expect(Game.find_by(:sport_name => "Spikeball").slots_taken).to eq(2)
    end
  end

  describe "Delete a game" do
    it "deletes the game" do
      @game = Game.where(:sport_name => "soccer").first

      get :destroy, {:id => @game.id}, {:user_id => @signed_in_player.id}
      expect(Game.where(:sport_name => "soccer").length).to eq(0)
    end
  end

  describe "Join a Game" do
    before(:all) do
      @game = Game.where(:sport_name => "soccer").first
    end

    it "adds the player to the game" do
      expect(@game.slots_taken).to eq(0)
      get :join, {:id => @game.id}, {:user_id => @signed_in_player.id}
      expect(Game.where(:sport_name => "soccer").first.slots_taken).to eq(1)
      expect(Game.where(:sport_name => "soccer").first.spots_left).to eq(9)
      expect(flash[:notice]).to eq("Successfully Joined Game")
    end

    it "displays on the details page" do
      get :join, {:id => @game.id}, {:user_id => @signed_in_player.id}

      get :show, {:id => @game.id}, {:user_id => @signed_in_player.id}
      expect(assigns(:players)).to include(@signed_in_player)
    end

    it "displays on the home page" do
      get :join, {:id => @game.id}, {:user_id => @signed_in_player.id}

      get :index, {}, {:user_id => @signed_in_player.id}
      expect(assigns(:games_player_joined)).to include(@game)
    end

    it "we already joined does nothing" do
      get :join, {:id => @game.id}, {:user_id => @signed_in_player.id}
      spots_left = Game.where(:sport_name => "soccer").first.spots_left
      get :join, {:id => @game.id}, {:user_id => @signed_in_player.id}
      expect(flash[:notice]).to eq("Already joined game")
      expect(Game.where(:sport_name => "soccer").first.spots_left).to eq(spots_left)
    end
  end


end