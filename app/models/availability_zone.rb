class AvailabilityZone < ApplicationRecord
  belongs_to :region
  has_many :spot_prices
end
