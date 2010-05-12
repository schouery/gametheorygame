class CreateSymmetricFunctionGameStrategies < ActiveRecord::Migration
  def self.up
    create_table :symmetric_function_game_strategies do |t|
      t.string :label
      t.integer :symmetric_function_game_id

      t.timestamps
    end
  end

  def self.down
    drop_table :symmetric_function_game_strategies
  end
end
