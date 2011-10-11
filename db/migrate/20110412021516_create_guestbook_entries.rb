class CreateGuestbookEntries < ActiveRecord::Migration
  def self.up
    create_table :guestbook_entries do |t|
      t.string :title, :null => false
      t.text :message, :null => false
      t.string :author, :null => false
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :guestbook_entries
  end
end
