class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :facebook_id, :limit => 20, :null => false
      t.boolean :admin
      t.boolean :researcher
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
