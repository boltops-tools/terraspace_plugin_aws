require "aws-sdk-dynamodb"
require "aws-sdk-ec2"
require "aws-sdk-s3"
require "aws-sdk-secretsmanager"
require "aws-sdk-ssm"

module TerraspacePluginAws
  module Clients
    extend Memoist
    include Options

    def ec2(options={})
      Aws::EC2::Client.new(client_options.merge(options))
    end
    memoize :ec2

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

    def sts
      Aws::STS::Client.new(client_options)
    end
    memoize :sts

    def dynamodb
      Aws::DynamoDB::Client.new(client_options)
    end
    memoize :dynamodb
  end
end
