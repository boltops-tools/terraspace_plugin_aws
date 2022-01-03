module TerraspacePluginAws::Interfaces::Helper
  class Secret < SecretBase
    def fetch(secret_id)
      secret_id = expansion(secret_id) if expand?
      value = fetch_value(secret_id)
      value = Base64.strict_encode64(value).strip if @base64
      value
    end

    def fetch_value(secret_id)
      secret_value = secretsmanager.get_secret_value(secret_id: secret_id)
      secret_value.secret_string
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException => e
      logger.info "WARN: secret_id #{secret_id} not found".color(:yellow)
      logger.info e.message
      "NOT FOUND #{secret_id}" # simple string so Kubernetes YAML is valid
    rescue Aws::SecretsManager::Errors::ValidationException => e
      logger.info "WARN: secret_id #{secret_id} not found".color(:yellow)
      logger.info e.message
      "INVALID NAME #{secret_id}" # simple string so tfvars valid
    end
  end
end
