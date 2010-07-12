class CreateItemSets < ActiveRecord::Migration
  def self.up
    create_table :item_sets do |t|
      t.string :name
      t.string :bonus_type
      t.timestamps
    end
  end

  def self.down
    drop_table :item_sets
  end
end
