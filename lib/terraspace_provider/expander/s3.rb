require "aws_data"

module TerraspaceProvider::Expander
  class S3
    include Terraspace::Provider::Expander::Interface
    delegate :account, :region, to: :aws_data

    def aws_data
      $__aws_data ||= AwsData.new
    end
  end
end
