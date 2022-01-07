class GamesController < ApplicationController
  before_action :require_game_created_by_player, only: [:edit, :update, :destroy]

  private

  def require_game_created_by_player
    @game = Game.find params[:id]
    if not @game.player_created_game?(session[:user_id])
      flash[:notice] = "Cannot edit a game you did not create"
      redirect_to games_path
    end
  end

  public

  def show
    id = params[:id] # retrieve movie ID from URI route
    @game = Game.find(id) # look up movie by unique ID
    @player_joined_game = @game.player_joined_game?(session[:user_id])
    @player_owns_game = @game.player_created_game?(session[:user_id])
    @players = @game.players
    address = ""
    if @game.address
      address = @game.address.gsub(' ','+') + "+"
    end
    @location = "https://www.google.com/maps/place/" + address + @game.zipcode
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
      ordering,@name_header = {:sport_name => :asc}, 'bg-warning hilite'
    when 'start'
      ordering,@start_header = {:game_start_time => :asc}, 'bg-warning hilite'
    end
    @player = Player.find(session[:user_id])
    @games_player_joined = @player.games
    @games = Game.where.not(id: @games_player_joined.ids)

    if @player.nil?
      redirect_to '/login'
    end
    @name = params[:name_search] || session[:name_search] || nil
    @zip = params[:zip_search] || session[:zip_search] || nil
    @available = params[:only_available] || nil

    if params[:sort] != session[:sort] or params[:name_search] != session[:name_search] or params[:zip_search] != session[:zip_search] or @available != session[:only_available]
      session[:sort] = sort
      session[:name_search] = @name
      session[:zip_search] = @zip
      session[:only_available] = params[:only_available]
      redirect_to :sort => sort, :name_search => @name, :zip_search => @zip, :only_available => @available and return
    end

    @games = Game.all().order(ordering)
    if not params[:name_search].blank?
      sport = params[:name_search].downcase
      @games = @games.where("lower(sport_name) LIKE :name_search", name_search: "%#{sport}%")
    end
    if not params[:zip_search].blank?
      zip = params[:zip_search].downcase
      @games = @games.where("zipcode LIKE :zip_search", zip_search: "%#{zip}%")
    end
    if params[:only_available] == "1"
      @games = @games.select {|game| game.spots_left > 0}
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    valid, notice = Game.add_game(game_params(), session[:user_id])
    flash[:notice] = notice
    if valid
      redirect_to games_path
    else
      redirect_to new_game_path
    end
  end

  def edit

  end

  def join
    @game = Game.find params[:id]
    player_id = session[:user_id]
    notice = @game.player_join_game(player_id)
    flash[:notice] = notice
    redirect_to game_path(@game)
  end

  def update
    valid, notice = @game.update_game(game_params())
    flash[:notice] = notice
    if valid
      redirect_to game_path(@game)
    else
      redirect_to edit_game_path(@game)
    end
  end

  def destroy
    @game.destroy
    flash[:notice] = "Game '#{@game.sport_name}' deleted."
    redirect_to games_path
  end

  private
  def game_params
    params.require(:game).permit(:sport_name, :address, :zipcode, :slots_to_be_filled, :game_start_time, :game_end_time)
  end
end