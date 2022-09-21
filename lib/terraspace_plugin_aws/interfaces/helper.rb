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
      vpc.vpc_id.to_json if vpc
    end
    memoize :aws_vpc_id

    def aws_vpc(name, **options)
      ec2 = aws_ec2(options) # client
      resp = ec2.describe_vpcs(filters: [{ name: "tag:Name", values: name }])
      resp.vpcs.first.to_json
    end
    memoize :aws_vpc

    def aws_subnet_ids(*names, **options)
      names = [names].flatten
      ec2 = aws_ec2(options) # client
      resp = ec2.describe_subnets(filters: [{ name: "tag:Name", values: names }])
      resp.subnets.map(&:subnet_id).sort.to_json
    end
    memoize :aws_subnet_ids
  end
end
