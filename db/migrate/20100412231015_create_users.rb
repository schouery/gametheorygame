class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :facebook_id, :limit => 20, :null => false
      t.boolean :admin, :default => false
      t.boolean :researcher, :default => false
      t.integer :money
      t.integer :score, :default => 0, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
