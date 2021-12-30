# Terraspace AWS Plugin

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

AWS Cloud support for terraspace.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'terraspace_plugin_aws'
```

## Configure

Terraspace Docs: [AWS Terraspace Plugin](https://terraspace.cloud/docs/plugins/aws/)

Optionally configure the plugin. Here's an example `aws.rb` for your terraspace project.

config/plugins/aws.rb

```ruby
TerraspacePluginAws.configure do |config|
  config.auto_create = true # set to false to completely disable auto creation

  config.s3.encryption = true
  config.s3.enforce_ssl = true
  config.s3.versioning = true
  config.s3.lifecycle = true
  config.s3.access_logging = false # false by default
  config.s3.secure_existing = false # run the security controls on existing buckets. by default, only run on newly created bucket the first time

  config.dynamodb.encryption = true
  config.dynamodb.kms_master_key_id = nil
  config.dynamodb.sse_type = "KMS"
end
```

By default:

* S3 Buckets are secured with [encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html), have an [enforce ssl bucket policy](https://aws.amazon.com/premiumsupport/knowledge-center/s3-bucket-policy-for-config-rule/), have [versioning enabled](https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html), has a [lifecycle policy](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/create-lifecycle.html), and have [bucket server access logging enabled](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html).
* DynamoDB tables have [encryption enabled](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/EncryptionAtRest.html) using the AWS Managed KMS Key for DynamoDB.

The settings generally only apply if the s3 bucket or dynamodb table do not yet exist yet and is created for the first time.

If using `kms_master_key_id` it must already exist.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boltops-tools/terraspace_plugin_aws.
