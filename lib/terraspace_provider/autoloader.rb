require "zeitwerk"

module TerraspaceProvider
  class Autoloader
    class Inflector < Zeitwerk::Inflector
      def camelize(basename, _abspath)
        map = { cli: "CLI", version: "VERSION" }
        map[basename.to_sym] || super
      end
    end

    class << self
      @@already_setup = false
      def setup
        return if @@already_setup
        loader = Zeitwerk::Loader.new
        loader.inflector = Inflector.new
        lib = File.expand_path("../", __dir__)
        loader.push_dir(lib)
        loader.ignore("#{lib}/terraspace-provider-aws.rb")
        loader.setup
        @@already_setup = true
      end
    end
  end
end
