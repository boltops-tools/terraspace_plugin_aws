lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for base classes

require "terraspace/provider/aws/version"
require "terraspace/provider/aws/autoloader"
Terraspace::Provider::Aws::Autoloader.setup

module Terraspace
  module Provider
    module Aws
      class Error < StandardError; end
    end
  end
end

# zeitwerk only autoloads from terraspace paths. Must require explicitly.
require "terraspace/auto/backend/s3"
