class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :facebook_id, :limit => 8, :null => false
      t.string :for

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
