module TerraspacePluginAws::Interfaces
  class Config
    include Terraspace::Plugin::Config::Interface
    include Singleton

    # interface method
    # load_project_config: config/plugins/aws.rb
    def provider
      "aws"
    end

    # interface method
    def defaults
      c = ActiveSupport::OrderedOptions.new
      c.s3 = ActiveSupport::OrderedOptions.new
      c.dynamodb = ActiveSupport::OrderedOptions.new

      c.s3.encryption = true
      c.s3.enforce_ssl = true
      c.s3.versioning = true
      c.s3.lifecycle = true
      c.s3.access_logging = true
      c.s3.secure_existing = false # run the security controls on existing buckets. by default, only run on newly created bucket the first time

      c.dynamodb.encryption = true
      c.dynamodb.kms_master_key_id = nil
      c.dynamodb.sse_type = "KMS"

      c
    end
  end
end
