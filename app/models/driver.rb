class Driver < ActiveRecord::Base
  has_one :cab
  has_many :trips, through: :cab
end
