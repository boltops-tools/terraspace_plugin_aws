require "aws-sdk-dynamodb"
require "aws-sdk-s3"
require "aws-sdk-secretsmanager"
require "aws-sdk-ssm"

module TerraspacePluginAws
  module Clients
    extend Memoist

    def s3
      Aws::S3::Client.new(client_options)
    end
    memoize :s3

    def secretsmanager
      Aws::SecretsManager::Client.new(client_options)
    end
    memoize :secretsmanager

    def ssm
      Aws::SSM::Client.new(client_options)
    end
    memoize :ssm

    def dynamodb
      Aws::DynamoDB::Client.new(client_options)
    end
    memoize :dynamodb

    # Typically inferred from AWS_REGION unless set in the backend.tf
    def client_options
      if @info['region']
        {region: @info['region']}
      else
        {}
      end
    end
  end
end
