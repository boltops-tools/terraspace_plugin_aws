class TerraspacePluginAws::Interfaces::Backend
  class Table < Base
    def create
      table = @info["dynamodb_table"]
      return unless table # not table provided

      if exist?(table)
        # puts "Table already exist: #{table}"
      else
        puts "Creating dynamodb table: #{table}"
        create_table(table)
      end
    end

    def create_table(name)
      dynamodb.create_table(table_definition(name))
      puts "Waiting for dynamodb table to finish creating..."
      dynamodb.wait_until(:table_exists, table_name: name)
    end

    def table_definition(name)
      definition = {
        attribute_definitions: [
          {
            attribute_name: "LockID",
            attribute_type: "S",
          }
        ],
        key_schema: [
          {
            attribute_name: "LockID",
            key_type: "HASH",
          }
        ],
        billing_mode: "PAY_PER_REQUEST", # accepts PROVISIONED, PAY_PER_REQUEST
        table_name: name,
      }
      secure(definition)
      definition
    end

    def secure(definition)
      c = TerraspacePluginAws::Interfaces::Config.instance.config.dynamodb
      return unless c.encryption

      # Docs: https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_SSESpecification.html
      #
      # If enabled (true), server-side encryption type is set to KMS and an AWS managed CMK is used (AWS KMS charges apply).
      # IE: If we want to use the "AWS Managed KMS Key", set `enable=true` and dont set any other values.
      #
      #     Setting                                             | Console
      #     --------------------------------------------------- | ---------------------------------------------------
      #     enable=false                                        | DEFAULT - The key is owned by Amazon DynamoDB. You are not charged any fee for using these CMKs.
      #     enable=true without sse_type, kms_master_key_id set | KMS - Customer managed CMK - The key is stored in your account that you create, own, and manage. AWS Key Management Service (KMS) charges apply
      #     enable=true with sse_type, kms_master_key_id set    | The key is stored in your account that you create, own, and manage. AWS Key Management Service (KMS) charges apply - The key is stored in your account that you create, own, and manage. AWS Key Management Service (KMS) charges apply
      #
      spec = {enabled: true}
      if c.kms_master_key_id
        spec[:sse_type]          = c.sse_type # accepts AES256, KMS
        spec[:kms_master_key_id] = c.kms_master_key_id
      end

      definition[:sse_specification] = spec
      definition
    end

    def exist?(name)
      dynamodb.describe_table(table_name: name)
      true  # table exist
    rescue Aws::DynamoDB::Errors::ResourceNotFoundException
      false # table does not exist
    end
  end
end
