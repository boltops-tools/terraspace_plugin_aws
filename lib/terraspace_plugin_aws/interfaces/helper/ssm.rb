module TerraspacePluginAws::Interfaces::Helper
  class SSM < SecretBase
    include Terraspace::Compiler::Dsl::Syntax::Mod::Backend
    extend Memoist

    def fetch(name)
      name = expansion(name) if expand?
      value = fetch_value(name)
      value = Base64.strict_encode64(value).strip if @base64
      value
    end

    def fetch_value(name)
      resp = ssm.get_parameter(name: name, with_decryption: true)
      resp.parameter.value
    rescue Aws::SSM::Errors::ParameterNotFound => e
      logger.info "WARN: name #{name} not found".color(:yellow)
      logger.info e.message
      "NOT FOUND #{name}" # simple string so tfvars valid
    rescue Aws::SSM::Errors::ValidationException => e
      logger.info "WARN: name #{name} not found".color(:yellow)
      logger.info e.message
      "INVALID NAME #{name}" # simple string so tfvars valid
    end
  end
end
