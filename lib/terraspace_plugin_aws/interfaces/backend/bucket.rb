class TerraspacePluginAws::Interfaces::Backend
  class Bucket < Base
    include Secure

    def create
      bucket = @info["bucket"]
      unless bucket # not bucket provided
        logger.error "ERROR: no bucket value provided in your terraform backend config".color(:red)
        exit 1
      end
      if exist?(bucket)
        logger.debug "Bucket already exist: #{bucket}"
        c = TerraspacePluginAws::Interfaces::Config.instance.config
        secure(bucket) if c.s3.secure_existing
        tag(bucket) if c.tag_existing
      else
        logger.info "Creating bucket: #{bucket}"
        s3.create_bucket(bucket: bucket)
        secure(bucket)
        tag(bucket)
      end
    end

    def exist?(name)
      s3.head_bucket(bucket: name, use_accelerate_endpoint: false)
      true  # Bucket exist
    rescue Aws::S3::Errors::NotFound
      false # Bucket does not exist
    rescue Aws::S3::Errors::Forbidden => e
      logger.error "#{e.class}: #{e.message}"
      logger.error "ERROR: Bucket is not available: #{name}".color(:red)
      logger.error "Bucket might be owned by someone else or is on another one of your AWS accounts."
      exit 1
    end

    def tag(bucket)
      Tagging.new(@info["bucket"]).tag
    end
  end
end
