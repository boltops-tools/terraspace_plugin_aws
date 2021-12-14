require "s3-secure"

class TerraspacePluginAws::Interfaces::Backend::Bucket
  module Secure
    # Why the retry logic?
    #
    # When using profile or role_arn in the terraform backend it the ruby aws sdk
    # assumes the profile or role.
    # In doing so, it errors when the s3-secure library calls s3_client.get_bucket_location
    #
    #   https://github.com/boltops-tools/s3-secure/blob/d2c8e9eba745a75d094a3c566bd5fe47476d3638/lib/s3_secure/aws_services/s3.rb#L43
    #
    # Here's an example stack trace of the error:
    #
    #   https://gist.github.com/tongueroo/dd74b67c17433c6f8dd890225104aef9
    #
    # Unsure if this is a terraform backend interfering with the ruby sdk thing (unlikely)
    # Or if it's a general AWS sdk thing.
    # Or if it's how I'm calling the sdk and initializing the client. Maybe an initializing the client early on and it caches it.
    # Unsure. But using this hack instead because life's short.
    #
    # Throwing the retry logic in here fixes the issue. This only happens the when the bucket is brand new.
    # Limiting the retry to only a single attempt.
    #
    @@retries = 0
    def secure(bucket)
      c = TerraspacePluginAws::Interfaces::Config.instance.config.s3
      options = {bucket: bucket, quiet: true}
      S3Secure::Encryption::Enable.new(options).run if c.encryption
      S3Secure::Policy::Enforce.new(options.merge(sid: "ForceSSLOnlyAccess")).run if c.enforce_ssl
      S3Secure::Versioning::Enable.new(options).run if c.versioning
      S3Secure::Lifecycle::Add.new(options).run if c.lifecycle
      S3Secure::AccessLogs::Enable.new(options).run if c.access_logging
    rescue Aws::S3::Errors::AccessDenied => e
      @@retries += 1
      retry unless @@retries > 1
    end
  end
end
