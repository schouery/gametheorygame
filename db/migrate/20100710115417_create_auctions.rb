class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.integer :user_id
      t.integer :item_id
      t.datetime :end_date
      t.integer :reserve_price, :default => 0
      t.integer :bid, :default => 0
      t.integer :bidder_id

      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
