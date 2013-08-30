class Team < ActiveRecord::Base
  has_many :competitions
  has_many :users
end
