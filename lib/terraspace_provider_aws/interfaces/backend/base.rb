class TerraspaceProviderAws::Interfaces::Backend
  class Base
    include TerraspaceProviderAws::Clients

    def initialize(info)
      @info = info
    end
  end
end
