# Changelog

All notable changes to this project will be documented in this file.
This project *loosely tries* to adhere to [Semantic Versioning](http://semver.org/).

## [0.4.2] - 2022-07-13
- [#22](https://github.com/boltops-tools/terraspace_plugin_aws/pull/22) add backend config variables docs comment

## [0.4.1] - 2022-06-14
- [#21](https://github.com/boltops-tools/terraspace_plugin_aws/pull/21) backend.tf template: add project variable

## [0.4.0] - 2022-06-10
- [#20](https://github.com/boltops-tools/terraspace_plugin_aws/pull/20) Update Generated Default Backend Key and CI Interface
- add ci interface class
- change default backend key

## [0.3.8] - 2022-06-09
- [#19](https://github.com/boltops-tools/terraspace_plugin_aws/pull/19) fix bucket tagging: use parsed region from backend.tf for s3 client

## [0.3.7] - 2022-02-15
- [#18](https://github.com/boltops-tools/terraspace_plugin_aws/pull/18) update starter s3 bucket example to work with terraform aws provider v4

## [0.3.6] - 2022-01-04
- [#17](https://github.com/boltops-tools/terraspace_plugin_aws/pull/17) aws_secret and aws_ssm: support expansion automatically

## [0.3.5] - 2021-12-30
- [#15](https://github.com/boltops-tools/terraspace_plugin_aws/pull/15) block public access support
- [#16](https://github.com/boltops-tools/terraspace_plugin_aws/pull/16) tagging support for s3 bucket and dynamodb table

## [0.3.4] - 2021-12-30
- [#13](https://github.com/boltops-tools/terraspace_plugin_aws/pull/13) check aws setup and provide friendly message
- [#14](https://github.com/boltops-tools/terraspace_plugin_aws/pull/14) fix aws_secret helper

## [0.3.3] - 2021-12-14
- [#10](https://github.com/boltops-tools/terraspace_plugin_aws/pull/10) implement expand_string? to not expand aws arn values

## [0.3.2] - 2021-12-14
- [#9](https://github.com/boltops-tools/terraspace_plugin_aws/pull/9) support separate aws account for s3 backend bucket

## [0.3.1] - 2021-12-14
- [#8](https://github.com/boltops-tools/terraspace_plugin_aws/pull/8) use region configured in the backend.tf for the s3 client

## [0.3.0] - 2020-11-15
- [#5](https://github.com/boltops-tools/terraspace_plugin_aws/pull/5) helper and secrets support
- aws_secret and aws_ssm helpers

## [0.2.2]
- #4 default access logging to false
- set prefix to @folder for performance improvement

## [0.2.1]
- #3 quiet s3-secure messages

## [0.2.0]
- #2 include layer interface, update template to expansion method

## [0.1.0]
- Initial release
