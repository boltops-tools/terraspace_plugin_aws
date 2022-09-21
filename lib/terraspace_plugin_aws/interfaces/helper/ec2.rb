module TerraspacePluginAws::Interfaces::Helper
  class Ec2
    include TerraspacePluginAws::Clients

    def client(options)
      ec2(options)
    end
  end
end
