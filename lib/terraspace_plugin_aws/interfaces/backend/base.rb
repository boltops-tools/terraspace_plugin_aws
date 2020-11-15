require "s3-secure"

class TerraspacePluginAws::Interfaces::Backend
  class Base
    include TerraspacePluginAws::Clients
    include TerraspacePluginAws::Logging

    def initialize(info)
      @info = info
    end
  end
end
