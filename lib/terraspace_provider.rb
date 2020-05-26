lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for base classes

require "terraspace_provider/version"
require "terraspace_provider/autoloader"
TerraspaceProvider::Autoloader.setup

module TerraspaceProvider
  class Error < StandardError; end
end
