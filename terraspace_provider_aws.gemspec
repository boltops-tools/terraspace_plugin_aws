require_relative 'lib/terraspace_provider/version'

Gem::Specification.new do |spec|
  spec.name          = "terraspace_provider_aws"
  spec.version       = TerraspaceProvider::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tung@boltops.com"]

  spec.summary       = "Terraspace AWS Provider"
  spec.homepage      = "https://github.com/boltops-tools/terraspace_provider_aws"
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

  spec.add_dependency "aws-sdk-s3"
  spec.add_dependency "aws_data"
  spec.add_dependency "memoist"
  # spec.add_dependency "terraspace"
  spec.add_dependency "zeitwerk"
end
