class TerraspacePluginAws::Interfaces::Backend
  class Setup < Base
    def check!
      sts.get_caller_identity
    rescue Aws::Errors::MissingCredentialsError => e
      logger.info "ERROR: #{e.class}: #{e.message}".color(:red)
      logger.info <<~EOL
        It doesnt look like AWS credentials and access has been setup.
        Please double check the AWS credentials setup.
        IE: ~/.aws/config and the AWS_PROFILE env variable.
      EOL
      exit 1
    end
  end
end
