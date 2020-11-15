require "base64"

module TerraspacePluginAws::Interfaces::Helper
  class SecretBase
    include TerraspacePluginAws::Clients
    include TerraspacePluginAws::Logging

    def initialize(options={})
      @options = options
      @base64 = options[:base64]
    end
  end
end
