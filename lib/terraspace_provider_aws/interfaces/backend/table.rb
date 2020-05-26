class TerraspaceProviderAws::Interfaces::Backend
  class Table < Base
    def create
      table = @info["dynamodb_table"]
      return unless table # not table provided

      if exist?(table)
        puts "Table already exist: #{table}"
      else
        puts "Creating dynamodb table: #{table}"
        create_table(table)
      end
    end

    def create_table(name)
      dynamodb.create_table(
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
      )
      puts "Waiting for dynamodb table to finish creating..."
      dynamodb.wait_until(:table_exists, table_name: name)
    end

    def exist?(name)
      dynamodb.describe_table(table_name: name)
      true  # table exist
    rescue Aws::DynamoDB::Errors::ResourceNotFoundException
      false # table does not exist
    end
  end
end
