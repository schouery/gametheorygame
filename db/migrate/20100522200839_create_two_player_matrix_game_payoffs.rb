class CreateTwoPlayerMatrixGamePayoffs < ActiveRecord::Migration
  def self.up
    create_table :two_player_matrix_game_payoffs do |t|
      t.integer :game_id
      t.integer :strategy1_id
      t.integer :strategy2_id
      t.integer :payoff_player_1
      t.integer :payoff_player_2
      t.integer :line_position
      t.integer :column_position
      t.timestamps
    end
  end

  def self.down
    drop_table :two_player_matrix_game_payoffs
  end
end
