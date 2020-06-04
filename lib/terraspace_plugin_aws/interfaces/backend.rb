module TerraspacePluginAws::Interfaces
  class Backend
    include Terraspace::Plugin::Backend::Interface

    # interface method
    def call
      return unless TerraspacePluginAws.config.auto_create

      Bucket.new(@info).create
      Table.new(@info).create
    end
  end
end
