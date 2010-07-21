class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.integer :money_gift_value, :default => 10
      t.boolean :full_permissions_to_researchers, :default => false
      t.boolean :researcher_can_invite_researcher, :default => false
      t.integer :card_gift_limit, :default => 10
      t.integer :money_gift_limit, :default => 10
      t.integer :item_gift_limit, :default => 10
      t.integer :starting_money, :default => 100
      t.integer :starting_cards, :default => 4
      t.float   :item_probability, :default => 0.1
      t.integer :starting_cards_per_hour, :default => 1
      t.integer :starting_hand_limit, :default => 10
      
      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
