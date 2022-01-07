Given /the following players exist/ do |players_table|
  players_table.hashes.each do |player|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Player.create(player)
  end
end

Given /^I am logged in as "(.*)"$/ do |uid|
  @current_user = Player.find_by(uid: uid)
  steps %Q{When I am on the login page for user "#{@current_user.id}"}
end

