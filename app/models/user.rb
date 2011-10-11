class User < ActiveRecord::Base
  has_many :user_roles
  has_many :roles, :through => :user_roles

  validates_presence_of :name, :hashed_password, :salt

  def self.authenticate(password)
    users = find(:all, :conditions => ['enabled = ?', true])
    users.detect do |user|
      user.hashed_password == encrypt(password, user.salt)
    end
  end

  def add_role(role)
    self.roles << role
  end

  def drop_role(role)
    self.roles.delete(role)
  end

  def admin?
    self.roles.include?(Role.admin)
  end

  # ------------------------
  #   Password Management
  # ------------------------

  def password=(new_password)
    unless(new_password.blank?)
      password = new_password
      self.salt = self.class.random_string(10) if !self.salt
      self.hashed_password = self.class.encrypt(password, salt)
    end
  end

  def password
    ''
  end

  def self.random_string(length)
    # Generates a random string consisting of letters, numbers, and punctuation.
    letters = ("a".."z").to_a + ("A".."Z").to_a
    numbers = ("0".."9").to_a
    punctuation = (' '..'/').to_a + (':'..'@').to_a + ('['..'`').to_a + ('{'..'~').to_a
    all_characters = letters + numbers + punctuation
    random_characters = []
    random_characters << letters.sample
    random_characters << numbers.sample
    random_characters << punctuation.sample
    (length - 3).times { random_characters << all_characters.sample }
    random_characters.shuffle.join
  end

  def self.encrypt(text, salt)
    Digest::SHA1.hexdigest(text+salt)
  end
end
