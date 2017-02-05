class SpotPrice < ApplicationRecord
  belongs_to :availability_zone
  belongs_to :instance_type
end
