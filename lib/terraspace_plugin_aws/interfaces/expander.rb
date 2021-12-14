require "aws_data"

module TerraspacePluginAws::Interfaces
  class Expander
    include Terraspace::Plugin::Expander::Interface
    delegate :account, :region, to: :aws_data
    alias_method :namespace, :account
    alias_method :location, :region

    def aws_data
      $__aws_data ||= AwsData.new
    end

    def expand_string?(string)
      !string.include?("arn:")
    end
  end
end
