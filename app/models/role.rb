class Role < ActiveRecord::Base
  has_many :users, :through => :user_roles

  validates_presence_of :name, :description

  def self.admin
    find(:first, :conditions => {:name => 'admin'})
  end
end
