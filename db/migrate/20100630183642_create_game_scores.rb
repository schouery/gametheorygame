class CreateGameScores < ActiveRecord::Migration
  def self.up
    create_table :game_scores do |t|
      t.integer :user_id
      t.integer :game_id
      t.string  :game_type
      t.integer :score, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :game_scores
  end
end
