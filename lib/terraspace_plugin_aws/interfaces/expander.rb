require "aws_data"

module TerraspacePluginAws::Interfaces
  class Expander
    include Terraspace::Plugin::Expander::Interface
    delegate :account, :region, to: :aws_data

    def aws_data
      $__aws_data ||= AwsData.new
    end
  end
end
