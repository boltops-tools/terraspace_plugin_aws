module TerraspacePluginAws::Interfaces
  class Decorator
    include Terraspace::Plugin::Decorator::Interface

    # interface method
    def call
      klass = decorator_class

      return @props unless klass
      decorator = klass.new(@props) # IE: AwsSecurityGroup.new(@props)
      decorator.call
    end

    def decorator_class
      # IE: TerraspacePluginAws::Interfaces::Decorator::AwsSecurityGroup
      klass_name = "TerraspacePluginAws::Interfaces::Decorator::#{@type.camelize}"
      klass_name.constantize
    rescue NameError
    end
  end
end
