class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :item_type_id
      t.integer :user_id
      t.boolean :used, :default => false
      t.integer :gift_for, :limit => 8
      
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
