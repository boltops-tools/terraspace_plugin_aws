lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for interface

require "terraspace_plugin_aws/version"
require "terraspace_plugin_aws/autoloader"
TerraspacePluginAws::Autoloader.setup

module TerraspacePluginAws
  class Error < StandardError; end

  # Friendlier method for config/plugins/aws.rb. Example:
  #
  #     TerraspacePluginAws.configure do |config|
  #       config.s3.encrypt = true
  #     end
  #
  def configure(&block)
    Interfaces::Config.instance.configure(&block)
  end
  extend self
end

Terraspace::Plugin.register("aws",
  backend: "s3",
  config_instance: TerraspacePluginAws::Interfaces::Config.instance,
  layer_class: TerraspacePluginAws::Interfaces::Layer, # used for layering
  root: File.dirname(__dir__),
)
