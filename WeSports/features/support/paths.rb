# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #

  def path_to(page_name)
    case page_name

    when /^the login page for user "(.*)"$/ then
      quick_login_path(Player.find_by(id: $1))
    when /^the (WeSports )?home\s?page$/ then '/games'
    when /^the new game page$/ then '/games/new'
    when /^the profile page for "(.*)"$/ then
      player_path(Player.find_by(username: $1))
    when /^the games page$/ then '/games'
    when /^the edit page for "(.*)"$/ then
      edit_game_path(Game.find_by(sport_name: $1))
    when /^the details page for "(.*)"$/
      game_path(Game.find_by(sport_name: $1))

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
