require "aws_data"

module TerraspacePluginAws::Interfaces
  class Layer
    include Terraspace::Plugin::Layer::Interface
    extend Memoist

    # interface method
    def namespace
      aws_data.account
    end

    # interface method
    def region
      aws_data.region
    end

    def aws_data
      AwsData.new
    end
    memoize :aws_data
  end
end
