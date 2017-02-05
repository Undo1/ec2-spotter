class InstanceType < ApplicationRecord
  has_many :spot_prices

  def self.update_types
    response = Net::HTTP.get_response "www.ec2instances.info", "/instances.json"

    JSON.parse(response.body).each do |type|
      begin
        t = InstanceType.find_or_create_by(:api_name => type["instance_type"])
        t.standard_price = type["pricing"]["us-east-1"]["linux"]["on-demand"]

        t.save! if t.changed?
      rescue
        puts "lost cause"
      end
    end

    return true
  end

  def update_spot_prices(region)
    client = AwsHelper.ec2_client region.api_name

    result = client.describe_spot_price_history({
      instance_types: [self.api_name],
      product_descriptions: [
        "Linux/UNIX (Amazon VPC)",
      ],
      start_time: 30.seconds.from_now.iso8601
    }).to_h[:spot_price_history_set]

    result.each do |spot_price|
      s = SpotPrice.new
      s.price = spot_price[:spot_price]
      s.availability_zone = AvailabilityZone.find_by_api_name(spot_price[:availability_zone])
      s.instance_type_id = self.id

      s.save!
    end
  end
end
