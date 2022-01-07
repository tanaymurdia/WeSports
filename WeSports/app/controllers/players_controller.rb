class PlayersController < ApplicationController
  def show
    id = params[:id]
    @player = Player.find(id) # look up movie by unique ID
    @games_created = @player.find_games_created()
    @games_joined = @player.games
    # will render app/views/players/show.<extension> by default
  end
end
