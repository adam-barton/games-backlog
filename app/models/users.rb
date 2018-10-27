class User < ActiveRecord::Base

  has_secure_password

  has_many :games
  
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end