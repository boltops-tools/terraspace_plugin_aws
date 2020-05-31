# Terraspace AWS Plugin

AWS Cloud support for terraspace.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'terraspace_plugin_aws'
```

## Configure

Optionally configure the plugin. Here's an example `aws.rb` for your terraspace project.

config/plugins/aws.rb

```ruby
TerraspacePluginAws.configure do |config|
  # config.s3.encryption = true
  # config.s3.enforce_ssl = true
  # config.s3.versioning = true
  # config.s3.lifecycle = true
  # config.s3.access_logging = true
  # config.s3.secure_existing = false # run the security controls on existing buckets. by default, only run on newly created bucket the first time
  #
  # config.dynamodb.encryption = true
  # config.dynamodb.kms_master_key_id = nil
  # config.dynamodb.sse_type = "KMS"
end
```

By default:

* S3 Buckets are secured with encryption, have an enforce ssl bucket policy, have versioning enabled, has a lifecycle policy, and have bucket access logging enabled.
* DynamoDB tables have encryption enabled using the AWS Managed KMS Key for DynamoDB.

The settings generally only apply if the s3 bucket or dynamodb table do not yet exist yet and is created for the first time.

If using `kms_master_key_id` it must already exist.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boltops-tools/terraspace_plugin_aws.
