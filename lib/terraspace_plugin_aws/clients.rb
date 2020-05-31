require "aws-sdk-dynamodb"
require "aws-sdk-s3"

module TerraspacePluginAws
  module Clients
    extend Memoist

    def s3
      Aws::S3::Client.new
    end
    memoize :s3

    def dynamodb
      Aws::DynamoDB::Client.new
    end
    memoize :dynamodb
  end
end
