class CreateMoneyGifts < ActiveRecord::Migration
  def self.up
    create_table :money_gifts do |t|
      t.integer :facebook_id, :limit => 8
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :money_gifts
  end
end
