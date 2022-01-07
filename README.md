# WeSports

## Run program locally
1. bundle install --without production
2. rake db:migrate
3. rake db:seed
4. rails server
5. In order for WeSports to function run on http://localhost:3000/

## Heroku
https://wesports-app.herokuapp.com/

## Github
https://github.com/tanaymurdia/WeSports

## Pages </br>
### Login </br>
Sign in button (redirects to google oauth) </br>
### Index </br>
Table with games available </br>
More info buttons on every game (redirect to game description) </br>
Filter for available only games </br>
Filter section (search bar for name and zip code) </br>
Sort by Sport Name and Start Time </br>
Create a game button (redirect to create page) </br>
View Profile Page </br>
### Game Description </br>
View game description (location/sport/college etc) </br>
View players that have join the game </br>
Join button (if slots are available) </br>
Delete game (if user is the owner) </br>
Back button (redirect to index) </br>
### Create (Where users can create event) </br>
Form with game description for user to fill </br>
Add game to the list of games table </br>
Create button (redirects to game description of the game created) </br>
### Edit Game Page </br>
Form to edit different attributes </br>
### Profile Page </br>
Table with games that user joined </br>
Table with games that user created </br>
Back button (redirect to index) </br>

## Problems Faced
1. RSpec at times does not run correctly, reach out to the team with any concerns
   1. Change the .rspec file to "--format documentation" if running into issues
2. If running locally, OAuth only works with localhost, port 3000 not 0.0.0.0
3. If running through container, make sure that it's still being connected through the localhost, port 3000 of the machine its running on
