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

  def config
    Interfaces::Config.instance.config
  end

  @@logger = nil
  def logger
    @@logger ||= Terraspace.logger
  end

  def logger=(v)
    @@logger = v
  end

  extend self
end

Terraspace::Plugin.register("aws",
  backend: "s3",
  config_class: TerraspacePluginAws::Interfaces::Config,
  helper_class: TerraspacePluginAws::Interfaces::Helper,
  layer_class: TerraspacePluginAws::Interfaces::Layer,
  root: File.dirname(__dir__),
)
