class TerraspaceProviderAws::Interfaces::Backend
  class Bucket < Base
    def create
      bucket = @info["bucket"]
      unless bucket # not bucket provided
        puts "ERROR: no bucket value provided in your terraform backend config".color(:red)
        exit 1
      end
      if exist?(bucket)
        puts "Bucket already exist: #{bucket}"
      else
        puts "Creating bucket: #{bucket}"
        s3.create_bucket(bucket: bucket)
      end
    end

    def exist?(name)
      s3.head_bucket(bucket: name, use_accelerate_endpoint: false)
      true  # Bucket exist
    rescue Aws::S3::Errors::NotFound
      false # Bucket does not exist
    rescue Aws::S3::Errors::Forbidden => e
      puts "#{e.class}: #{e.message}"
      puts "ERROR: Bucket is not available: #{name}".color(:red)
      puts "Bucket might be owned by someone else or is on another one of your AWS accounts."
      exit 1
    end
  end
end
