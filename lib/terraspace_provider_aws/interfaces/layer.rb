require "aws_data"

module TerraspaceProviderAws::Interfaces
  class Layer
    extend Memoist

    # interface method
    def region
      aws_data.region
    end

    # interface method
    def account
      aws_data.account
    end

    # interface method
    def provider
      "aws"
    end

    def aws_data
      AwsData.new
    end
    memoize :aws_data
  end
end
