module TerraspaceProviderAws::Interfaces
  class Backend
    include Terraspace::Provider::Backend::Interface

    def call
      Bucket.new(@info).create
      Table.new(@info).create
    end
  end
end
