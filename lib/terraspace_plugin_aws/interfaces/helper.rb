require "active_support/core_ext/array"

module TerraspacePluginAws::Interfaces
  module Helper
    extend Memoist
    include Terraspace::Plugin::Helper::Interface

    def aws_secret(name, options={})
      Secret.new(@mod, options).fetch(name)
    end

    def aws_ssm(name, options={})
      SSM.new(@mod, options).fetch(name)
    end

    def aws_ec2(options={})
      Ec2.new.client(options)
    end

    def aws_vpc_id(name, **options)
      vpc = aws_vpc(name, options)
      vpc.vpc_id if vpc
    end
    memoize :aws_vpc_id

    def aws_vpc(name, **options)
      ec2 = aws_ec2(options) # client
      resp = ec2.describe_vpcs(filters: [{ name: "tag:Name", values: [name] }])
      resp.vpcs.first
    end
    memoize :aws_vpc

    def aws_subnet_ids(*names)
      names = [names].flatten
      options = names.extract_options!
      ec2 = aws_ec2(options) # client
      resp = ec2.describe_subnets(filters: [{ name: "tag:Name", values: names }])
      resp.subnets.map(&:subnet_id).sort
    end
    memoize :aws_subnet_ids
  end
end
