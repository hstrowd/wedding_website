class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name,        :null => false
      t.string :description, :null => false

      t.timestamps
    end

    admin_role = Role.create(:name => 'admin', 
                             :description => 'Role used for administrative users only')
    attendee_role = Role.create(:name => 'attendee', 
                             :description => 'Role for individuals attending the wedding. Gives them access to accomodation, event, and timing information.')

    create_table :users do |t|
      t.string  :name, :null => false
      t.string  :hashed_password, :null => false
      t.string  :salt, :null => false
      t.boolean :enabled, :null => false

      t.timestamps
    end

    create_table :user_roles do |t|
      t.integer :role_id, :null => false
      t.integer :user_id, :null => false
      
      t.timestamps
    end

    admin_user = User.new(:name => 'admin', :password => 'adminPassword', :enabled => true)
    admin_user.add_role(admin_role)
    admin_user.save!

    attendee_user = User.new(:name => 'attendee', :password => 'password', :enabled => true)
    attendee_user.add_role(attendee_role)
    attendee_user.save!
  end

  def self.down
    drop_table :user_roles
    drop_table :users
    drop_table :roles
  end
end
