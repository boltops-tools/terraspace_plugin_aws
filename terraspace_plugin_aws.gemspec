require_relative 'lib/terraspace_plugin_aws/version'

Gem::Specification.new do |spec|
  spec.name          = "terraspace_plugin_aws"
  spec.version       = TerraspacePluginAws::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tung@boltops.com"]

  spec.summary       = "Terraspace AWS Plugin"
  spec.homepage      = "https://github.com/boltops-tools/terraspace_plugin_aws"
  spec.license       = "Apache2.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk-dynamodb"
  spec.add_dependency "aws-sdk-ec2"
  spec.add_dependency "aws-sdk-s3"
  spec.add_dependency "aws-sdk-secretsmanager"
  spec.add_dependency "aws-sdk-ssm"
  spec.add_dependency "aws_data"
  spec.add_dependency "memoist"
  spec.add_dependency "s3-secure", "~> 0.6.1"
  spec.add_dependency "zeitwerk"
end
