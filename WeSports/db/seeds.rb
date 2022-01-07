# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


players = [{:username => 'Samuel Raab', :email => 'samraab@gmail.com'},
					 {:username => 'Jenny Martinez', :email => 'jenny@columbia.edu'},
					 {:username => 'Joe Shmo', :email => 'joeshmo@columbia.edu'}
]

players.each do |player|
	p = Player.create!(player)
end

games = [{:sport_name => 'Basketball', :address => '362 Riverside Dr', :zipcode => '10025', :slots_to_be_filled => 10, :game_start_time => '10-Dec-2021 16:00:00', :game_end_time => '10-Dec-2021 18:00:00'},
         {:sport_name => 'Running', :address => '70 Morningside Dr', :zipcode => '10027', :slots_to_be_filled => 2, :game_start_time => '15-Dec-2021 08:30:00'},
         {:sport_name => 'Basketball', :address => '22 W 76th St', :zipcode => '10023', :slots_to_be_filled => 4, :game_start_time => '15-Dec-2021 08:00:00', :game_end_time => '15-Dec-2021 10:00:00'},
         {:sport_name => 'Running', :address => '435 W 116th', :zipcode => '10027', :slots_to_be_filled => 2, :game_start_time => '8-Dec-2021 10:45:00'},
         {:sport_name => 'Spikeball', :address => '2554 Broadway', :zipcode => '10025', :slots_to_be_filled => 4, :game_start_time => '11-Dec-2021 15:45:00', :game_end_time => '11-Dec-2021 17:00:00'}
]

games.each do |game|
  g = Game.create!(game)
  g.owning_player = Player.first
  g.save()
  g.players << Player.first
  g.players << Player.second
end



