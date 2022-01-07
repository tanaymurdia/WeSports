require 'rails_helper'
require 'simplecov'

RSpec.describe SessionsController, type: :controller do
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
    if Player.where(:email => "Stephane@gmail.com").empty?
      @test_player=Player.create(:email => "Stephane@gmail.com",
                                 :uid => "1",
                                 :username => 'Stephane',
                                 :provider => 'google_oauth2')
    end
    if Player.where(:email => "Tom@gmail.com").empty?
      Player.create(:email => "Tom@gmail.com",
                    :uid => "2",
                    :username => 'Tom',
                    :provider => 'google_oauth2')
    end
    if Player.where(:email => "Sam@gmail.com").empty?
      Player.create(:email => "Sam@gmail.com",
                    :uid => "3",
                    :username => 'Sam',
                    :provider => 'google_oauth2')
    end
    if Player.where(:email => "Jenny@gmail.com").empty?
      Player.create(:email => "Jenny@gmail.com",
                    :uid => "4",
                    :username => 'Jenny',
                    :provider => 'google_oauth2')
    end
  end

  after(:all) do
    Player.delete_all
    Game.delete_all
  end

  describe "When creating with valid credentials" do
    it "should correctly login " do
      get  :create, {:email => @test_player.email}
      expect(response).to redirect_to user_path(@test_player)
    end
  end


  describe "When creating with invalid credentials" do
    it "should redirect to login and flash message " do
      get  :create
      expect(response).to redirect_to '/login'
      expect(flash[:message]).to match("Invalid credentials. Please try again.")
    end
  end

  describe "When destroying the session" do
    it "should redirect to login " do
      get  :destroy ,{:user_id => @test_player.id}
      expect(response).to redirect_to '/login'
    end
  end

  #describe "When creating from Omniauth with valid" do
  #it "should redirect to games_path" do
  #auth = {"uid" => "1", "provider"=>"google_oauth2", "info" => {"first_name"=> "fake","email"=> "fakemail@you.com"} }
  #user = Player.create_from_omniauth(auth)
  #get  '/auth/:provider/callback'
  #expect(response).to redirect_to games_path
  #end
  #end

  #describe "When creating from Omniauth with valid" do
  #it "should flash message" do
  #get  :omniauth
  #end
  #end

end

