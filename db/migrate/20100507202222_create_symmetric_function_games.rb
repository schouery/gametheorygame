class CreateSymmetricFunctionGames < ActiveRecord::Migration
  def self.up
    create_table :symmetric_function_games do |t|
      t.string :name
      t.text :description
      t.integer :number_of_players
      t.string :label_1
      t.string :label_2
      t.string :color
      t.string :function
      t.timestamps
    end
  end

  def self.down
    drop_table :symmetric_function_games
  end
end
