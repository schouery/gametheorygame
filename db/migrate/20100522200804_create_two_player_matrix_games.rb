class CreateTwoPlayerMatrixGames < ActiveRecord::Migration
  def self.up
    create_table :two_player_matrix_games do |t|
      t.string :name
      t.text :description
      t.string :color

      t.timestamps
    end
  end

  def self.down
    drop_table :two_player_matrix_games
  end
end
