module TerraspacePluginAws::Interfaces
  class Summary
    include Terraspace::Plugin::Summary::Interface
    include TerraspacePluginAws::Clients

    # interface method
    def download
      resp = s3.list_objects(bucket: @bucket, prefix: @folder)
      resp.contents.each do |content|
        local_path = "#{@dest}/#{content.key}"
        FileUtils.mkdir_p(File.dirname(local_path))
        s3.get_object(
          response_target: local_path,
          bucket: @bucket,
          key: content.key,
        )
      end
    end

    # interface method
    def delete_empty_statefile(key)
      delete_lock_id(key)
      delete_s3_file(key)
    end

  private
    def delete_s3_file(key)
      s3.delete_object(
        bucket: @bucket,
        key: key,
      )
      # resp is:
      #
      #   <struct Aws::S3::Types::DeleteObjectOutput
      #    delete_marker=nil,
      #    version_id=nil,
      #    request_charged=nil>
    end

    def delete_lock_id(key)
      lock_id = "#{@bucket}/#{key}-md5"
      table_name = @info['dynamodb_table']
      dynamodb.delete_item(
        key: {LockID: lock_id},
        table_name: table_name,
      )
      # resp is:
      #
      #   #<struct Aws::DynamoDB::Types::DeleteItemOutput
      #    attributes=nil,
      #    consumed_capacity=nil,
      #    item_collection_metrics=nil>
    rescue Aws::DynamoDB::Errors::ResourceNotFoundException => e
      # Exception happens when dynamodb table doesnt exist
      # If the lock item is missing, it successfully sends the api call to delete, even though there's nothing to delete
      logger.error "ERROR: #{e.class}: #{e.message}"
      logger.error "Table may not exist"
    end
  end
end
