module TerraspacePluginAws::Interfaces
  class Backend
    include Terraspace::Plugin::Backend::Interface

    # interface method
    def call
      return unless TerraspacePluginAws.config.auto_create

      Setup.new(@info).check!
      Bucket.new(@info).create
      Table.new(@info).create
    end
  end
end
