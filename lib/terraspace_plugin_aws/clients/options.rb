module TerraspacePluginAws::Clients
  module Options
  private
    def client_options(options={})
      return options unless @info # aws_secret helper wont have @info
      if @info['role_arn']
        client_assume_role_options
      else
        client_default_options
      end
    end

    # Typically, aws sdk client options are inferred from the user environment unless set in the backend.tf
    #
    # terraform s3 backend assume role configuration: https://www.terraform.io/docs/language/settings/backends/s3.html
    #
    #     assume_role_duration_seconds - (Optional) Number of seconds to restrict the assume role session duration.
    #     assume_role_policy - (Optional) IAM Policy JSON describing further restricting permissions for the IAM Role being assumed.
    #     assume_role_policy_arns - (Optional) Set of Amazon Resource Names (ARNs) of IAM Policies describing further restricting permissions for the IAM Role being assumed.
    #     assume_role_tags - (Optional) Map of assume role session tags.
    #     assume_role_transitive_tag_keys - (Optional) Set of assume role session tag keys to pass to any subsequent sessions.
    #     external_id - (Optional) External identifier to use when assuming the role.
    #     role_arn - (Optional) Amazon Resource Name (ARN) of the IAM Role to assume.
    #     session_name - (Optional) Session name to use when assuming the role.
    #
    # ruby sdk: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/AssumeRoleCredentials.html
    #
    #     :role_arn (required, String)
    #     :role_session_name (required, String)
    #     :policy (String)
    #     :duration_seconds (Integer)
    #     :external_id (String)
    #     :client (STS::Client)
    #
    def client_assume_role_options
      whitelist = %w[
        assume_role_duration_seconds
        assume_role_policy
        session_name
        external_id
        role_arn
      ]
      assume_role_config = @info.slice(*whitelist)
      # not supported?
      #   assume_role_policy_arns
      #   assume_role_tags
      #   assume_role_transitive_tag_keys
      # already matches
      #   external_id
      #   role_arn
      # rest needs to be mapped
      map = {
        'assume_role_duration_seconds' => 'duration_seconds',
        'assume_role_policy' => 'policy',
        'session_name' => 'role_session_name',
      }
      map.each do |terraform_key, ruby_sdk_key|
        v = assume_role_config.delete(terraform_key)
        assume_role_config[ruby_sdk_key] = v if v
      end
      assume_role_config.symbolize_keys! # ruby sdk expects symbols for keys
      assume_role_config[:role_session_name] ||= [ENV['C9_USER'] || ENV['USER'], 'session'].compact.join('-') # session name is required for the ruby sdk
      role_credentials = Aws::AssumeRoleCredentials.new(assume_role_config)
      {credentials: role_credentials}
    end

    # terraform s3 backend configuration: https://www.terraform.io/docs/language/settings/backends/s3.html
    #
    #     access_key - (Optional) AWS access key. If configured, must also configure secret_key. This can also be sourced from the AWS_ACCESS_KEY_ID environment variable, AWS shared credentials file (e.g. ~/.aws/credentials), or AWS shared configuration file (e.g. ~/.aws/config).
    #     secret_key - (Optional) AWS access key. If configured, must also configure access_key. This can also be sourced from the AWS_SECRET_ACCESS_KEY environment variable, AWS shared credentials file (e.g. ~/.aws/credentials), or AWS shared configuration file (e.g. ~/.aws/config).
    #
    # ruby sdk: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Credentials.html
    #
    #     access_key_id (String)
    #     secret_access_key (String)
    #     session_token (String) (defaults to: nil) — (nil)
    #
    def client_default_options
      whitelist = %w[
        access_key_id
        secret_access_key
        session_token
        profile
      ]
      options = @info.slice(*whitelist)
      options.symbolize_keys! # ruby sdk expects symbols for keys
      client_region_option.merge(options)
    end

    def client_region_option
      if @info['region']
        {region: @info['region']}
      else
        {}
      end
    end
  end
end
