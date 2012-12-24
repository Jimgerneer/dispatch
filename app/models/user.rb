class User < ActiveRecord::Base
  attr_accessible :username

  has_many :reports
end
