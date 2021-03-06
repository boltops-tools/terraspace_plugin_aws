require "s3-secure"

class TerraspacePluginAws::Interfaces::Backend::Bucket
  module Secure
    def secure(bucket)
      c = TerraspacePluginAws::Interfaces::Config.instance.config.s3
      options = {bucket: bucket, quiet: true}
      S3Secure::Encryption::Enable.new(options).run if c.encryption
      S3Secure::Policy::Enforce.new(options.merge(sid: "ForceSSLOnlyAccess")).run if c.enforce_ssl
      S3Secure::Versioning::Enable.new(options).run if c.versioning
      S3Secure::Lifecycle::Add.new(options).run if c.lifecycle
      S3Secure::AccessLogs::Enable.new(options).run if c.access_logging
    end
  end
end
