class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.integer :money_gift_value, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
