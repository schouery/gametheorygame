class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.integer :user_id
      t.integer :payoff
      t.integer :game_id
      t.string  :game_type
      t.integer :strategy_id
      t.string  :strategy_type
      t.integer :player_number, :default => 0
      t.integer :game_result_id
      t.integer :gift_for, :limit => 8
      t.boolean :played, :default => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
