require "aws_data"

module TerraspaceProviderAws::Interfaces
  class Expander
    include Terraspace::Provider::Expander::Interface
    delegate :account, :region, to: :aws_data

    def aws_data
      $__aws_data ||= AwsData.new
    end
  end
end
