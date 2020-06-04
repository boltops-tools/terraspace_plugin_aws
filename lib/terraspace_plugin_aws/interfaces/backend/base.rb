require "s3-secure"

class TerraspacePluginAws::Interfaces::Backend
  class Base
    include TerraspacePluginAws::Clients

    def initialize(info)
      @info = info
    end

    def logger
      Terraspace.logger
    end
  end
end
