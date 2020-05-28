source "https://rubygems.org"

# Specify your gem's dependencies in gemspec
gemspec

gem "rake", "~> 12.0"
gem "rspec", "~> 3.0"

group :development, :test do
  base = ENV['TS_BASE_FOLDER'] || "#{ENV['HOME']}/environment"
  gem "terraspace", path: "#{base}/terraspace"
end
