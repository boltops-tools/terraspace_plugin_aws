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

      c.auto_create = true
      c.tags = {} # can set tags for both s3 bucket and dynamodb table with this config
      c.tag_existing = true

      c.s3 = ActiveSupport::OrderedOptions.new
      c.s3.access_logging = false
      c.s3.block_public_access = true
      c.s3.encryption = true
      c.s3.enforce_ssl = true
      c.s3.lifecycle = true
      c.s3.versioning = true
      c.s3.secure_existing = false # run the security controls on existing buckets. by default, only run on newly created bucket the first time
      c.s3.tags = {} # cannot assign to c.tags here because it's a copy

      c.dynamodb = ActiveSupport::OrderedOptions.new
      c.dynamodb.encryption = true
      c.dynamodb.kms_master_key_id = nil
      c.dynamodb.sse_type = "KMS"
      c.dynamodb.tags = {} # cannot assign to c.tags here because it's a copy

      c
    end
  end
end
