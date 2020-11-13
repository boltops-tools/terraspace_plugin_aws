require "aws-sdk-dynamodb"
require "aws-sdk-s3"
require "aws-sdk-secretsmanager"
require "aws-sdk-ssm"

module TerraspacePluginAws
  module Clients
    extend Memoist

    def s3
      Aws::S3::Client.new
    end
    memoize :s3

    def secretsmanager
      Aws::SecretsManager::Client.new
    end
    memoize :secretsmanager

    def ssm
      Aws::SSM::Client.new
    end
    memoize :ssm

    def dynamodb
      Aws::DynamoDB::Client.new
    end
    memoize :dynamodb
  end
end
