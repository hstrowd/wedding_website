class AddPublishedColumnToGuestbookEntries < ActiveRecord::Migration
  def self.up
    add_column :guestbook_entries, :published, :boolean, :default => true
  end

  def self.down
    remove_column :guestbook_entries, :published
  end
end
