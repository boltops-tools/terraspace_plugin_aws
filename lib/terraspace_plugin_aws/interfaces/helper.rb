module TerraspacePluginAws::Interfaces
  module Helper
    def aws_secret(name, options={})
      Secret.new(options).fetch(name)
    end

    def aws_ssm(name, options={})
      SSM.new(options).fetch(name)
    end
  end
end
