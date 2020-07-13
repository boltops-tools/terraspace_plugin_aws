module TerraspacePluginAws::Interfaces
  class Summary
    include Terraspace::Plugin::Summary::Interface
    include TerraspacePluginAws::Clients

    # interface method
    def download
      resp = s3.list_objects(bucket: @bucket)
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
  end
end
