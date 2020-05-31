module TerraspacePluginAws::Interfaces
  class Backend
    include Terraspace::Plugin::Backend::Interface

    # interface method
    def call
      Bucket.new(@info).create
      Table.new(@info).create
    end
  end
end
