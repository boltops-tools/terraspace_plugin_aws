lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for base classes

require "terraspace_provider_aws/version"
require "terraspace_provider_aws/autoloader"
TerraspaceProviderAws::Autoloader.setup

module TerraspaceProviderAws
  class Error < StandardError; end
end

Terraspace::Provider.register("s3", "aws")
