class GuestbookEntry < ActiveRecord::Base
  validates_presence_of :author, :title, :message 
  validates_each :email do |model, attr, value|
    if(!value.blank? && !(value =~ /^[A-Za-z0-9][A-Za-z0-9_-]*(\.[A-Za-z0-9_-]+)*@[A-Za-z0-9][A-Za-z0-9_-]*(\.[A-Za-z0-9_-]+)*\.[A-Za-z]{2,4}$/))
      model.errors.add(:email, 'is not valid.')
    end
  end
end
