class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username
      t.string :email
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
