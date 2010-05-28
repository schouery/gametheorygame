class CreateTwoPlayerMatrixGameStrategies < ActiveRecord::Migration
  def self.up
    create_table :two_player_matrix_game_strategies do |t|
      t.string :label
      t.integer :player_number
      t.integer :game_id
      t.integer :number
      t.timestamps
    end
  end

  def self.down
    drop_table :two_player_matrix_game_strategies
  end
end
