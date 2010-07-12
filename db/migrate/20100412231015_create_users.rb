class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :facebook_id, :limit => 8, :null => false
      t.boolean :admin, :default => false
      t.boolean :researcher, :default => false
      t.integer :money
      t.integer :score, :default => 0, :null => false
      t.integer :cards_per_hour
      t.integer :hand_limit
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
