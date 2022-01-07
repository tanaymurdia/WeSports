require 'rails_helper'

RSpec.describe Player, type: :model do
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


  describe "When creating from Omniauth with valid" do
    it "should redirect to games_path" do
      auth = {"uid" => "5", "provider"=>"google_oauth2", "info" => {"first_name"=> "fake","email"=> "fake@gmail.com"} }
      user = Player.create_from_omniauth(auth)
      expect(Player.find_by(uid: "5").username).to eq(auth["info"]["first_name"])
    end
  end
end
