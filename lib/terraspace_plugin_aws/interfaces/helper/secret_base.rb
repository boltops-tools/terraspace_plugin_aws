require "base64"

module TerraspacePluginAws::Interfaces::Helper
  class SecretBase
    include TerraspacePluginAws::Clients
    include TerraspacePluginAws::Logging
    extend Memoist

    def initialize(mod, options={})
      @mod = mod
      @options = options
      @base64 = options[:base64]
    end

  private
    delegate :expansion, to: :expander
    def expander
      TerraspacePluginAws::Interfaces::Expander.new(@mod)
    end
    memoize :expander

    def expand?
      !(@options[:expansion] == false || @options[:expand] == false)
    end
  end
end
