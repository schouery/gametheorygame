class CreateGiftLogs < ActiveRecord::Migration
  def self.up
    create_table :gift_logs do |t|
      t.integer :user_id
      t.integer :number_of_money_gifts, :default => 0
      t.integer :number_of_card_gifts, :default => 0
      t.date :money_gift_sent_on, :default => Date.today
      t.date :card_gift_sent_on, :default => Date.today

      t.timestamps
    end
  end

  def self.down
    drop_table :gift_logs
  end
end
