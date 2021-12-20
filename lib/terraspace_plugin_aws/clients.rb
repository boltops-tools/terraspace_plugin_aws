require "aws-sdk-dynamodb"
require "aws-sdk-s3"
require "aws-sdk-secretsmanager"
require "aws-sdk-ssm"

module TerraspacePluginAws
  module Clients
    extend Memoist
    include Options

    def s3
      if @info
        Aws::S3::Client.new(client_options)
      else
        Aws::S3::Client.new
      end
    end
    memoize :s3

    def secretsmanager
      if @info
        Aws::SecretsManager::Client.new(client_options)
      else
        Aws::SecretsManager::Client.new
      end
    end
    memoize :secretsmanager

    def ssm
      if @info
        Aws::SSM::Client.new(client_options)
      else
        Aws::SSM::Client.new
      end
    end
    memoize :ssm

    def dynamodb
      if @info
        Aws::DynamoDB::Client.new(client_options)
      else
        Aws::DynamoDB::Client.new
      end
    end
    memoize :dynamodb
  end
end
