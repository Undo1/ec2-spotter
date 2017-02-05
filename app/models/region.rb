class Region < ApplicationRecord
  has_many :availability_zones
  has_many :spot_prices, through: :availability_zones

  def self.update_regions
    client = AwsHelper.ec2_client

    client.describe_regions[:region_info].each do |region|
      r = Region.find_or_create_by(:api_name => region[:region_name])
    end
  end

  def update_availability_zones
    client = AwsHelper.ec2_client self.api_name

    client.describe_availability_zones[:availability_zone_info].each do |availability_zone|
      az = AvailabilityZone.find_or_create_by(:api_name => availability_zone[:zone_name])
      az.region = self
      az.save! if az.changed?
    end
  end

  def update_spot_prices
    client = AwsHelper.ec2_client self.api_name

    instance_types = InstanceType.pluck(:api_name, :id).to_h
    availability_zones = self.availability_zones.pluck(:api_name, :id).to_h

    client.describe_spot_price_history({
      end_time: 30.seconds.from_now,
      instance_types: InstanceType.pluck(:api_name),
      product_descriptions: [
        "Linux/UNIX (Amazon VPC)",
      ],
      start_time: Time.now,
    }).spot_price_history.each do |spot_price_history|
      SpotPrice.create(:price => spot_price_history.spot_price,
                       :availability_zone_id => availability_zones[spot_price_history.availability_zone],
                       :instance_type_id => instance_types[spot_price_history.instance_type])
    end
  end
end
