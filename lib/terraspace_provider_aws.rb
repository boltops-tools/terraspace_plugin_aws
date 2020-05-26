lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for interface

require "terraspace_provider_aws/version"
require "terraspace_provider_aws/autoloader"
TerraspaceProviderAws::Autoloader.setup

module TerraspaceProviderAws
  class Error < StandardError; end
end

Terraspace::Provider.register("aws",
  backend: "s3",
  root: File.dirname(__dir__)
)
