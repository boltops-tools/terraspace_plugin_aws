require "s3-secure"

class TerraspacePluginAws::Interfaces::Backend::Bucket
  module Secure
    def secure(bucket)
      c = TerraspacePluginAws::Interfaces::Config.instance.config.s3

      S3Secure::Encryption::Enable.new(bucket: bucket).run if c.encryption
      S3Secure::Policy::Enforce.new(bucket: bucket, sid: "ForceSSLOnlyAccess").run if c.enforce_ssl
      S3Secure::Versioning::Enable.new(bucket: bucket).run if c.versioning
      S3Secure::Lifecycle::Add.new(bucket: bucket).run if c.lifecycle
      S3Secure::AccessLogs::Enable.new(bucket: bucket).run if c.access_logging
    end
  end
end
