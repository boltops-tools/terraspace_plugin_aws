module TerraspaceProviderAws::Interfaces
  class Decorator
    include Terraspace::Provider::Decorator::Interface

    def call
      klass = decorator_class

      return @props unless klass
      decorator = klass.new(@props) # IE: AwsSecurityGroup.new(@props)
      decorator.call
    end

    def decorator_class
      # IE: TerraspaceProviderAws::Interfaces::Decorator::AwsSecurityGroup
      klass_name = "TerraspaceProviderAws::Interfaces::Decorator::#{@type.camelize}"
      klass_name.constantize
    rescue NameError
    end
  end
end
