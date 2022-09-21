module TerraspacePluginAws::Interfaces
  module Helper
    include Terraspace::Plugin::Helper::Interface
    include TerraspacePluginAws::Clients

    def aws_secret(name, options={})
      Secret.new(@mod, options).fetch(name)
    end

    def aws_ssm(name, options={})
      SSM.new(@mod, options).fetch(name)
    end

    # IE: aws_ec2_describe_subnets -> ec2.describe_subnets
    def method_missing(name, *options, &block)
      if name.include?("aws_ec2_")
        delegate_meth = name.sub(/^aws_ec2_/,'')
        ec2.send(delegate_meth, *options, &block)
      else
        super
      end
    end
  end
end
