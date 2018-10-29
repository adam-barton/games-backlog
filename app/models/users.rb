class User < ActiveRecord::Base
  
   has_many :games

  has_secure_password

 
  
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end