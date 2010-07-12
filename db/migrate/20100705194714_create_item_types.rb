class CreateItemTypes < ActiveRecord::Migration
  def self.up
    create_table :item_types do |t|
      t.string :name
      t.integer :item_set_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_types
  end
end
