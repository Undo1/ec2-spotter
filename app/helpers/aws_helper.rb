module AwsHelper
  def self.ec2_client(region='us-east-1')
    config = AppConfig["aws_credentials"]

    return Aws::EC2::Client.new(
      region: region,
      access_key_id: config["access_token"],
      secret_access_key: config["secret_token"]
    )
  end
end
