module TerraspacePluginAws::Interfaces
  module Helper
    include Terraspace::Plugin::Helper::Interface

    def aws_secret(name, options={})
      Secret.new(options).fetch(name)
    end
    cache_helper :aws_secret

    def aws_ssm(name, options={})
      SSM.new(options).fetch(name)
    end
    cache_helper :aws_ssm
  end
end
