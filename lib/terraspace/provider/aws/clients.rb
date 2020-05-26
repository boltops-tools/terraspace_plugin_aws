require "aws-sdk-s3"

module Terraspace::Provider::Aws
  # Use AwsServices so it doesnt collide with Aws. It's more work to remember to type ::Aws
  module Clients
    extend Memoist

    def s3
      Aws::S3::Client.new
    end
    memoize :s3
  end
end
