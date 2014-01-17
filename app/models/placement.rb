class Placement < ActiveRecord::Base
  belongs_to :couple
  belongs_to :event
end
