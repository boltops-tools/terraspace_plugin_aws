class TerraspacePluginAws::Interfaces::Backend::Bucket
  class Tagging
    include TerraspacePluginAws::Clients
    include TerraspacePluginAws::Logging

    def initialize(bucket)
      @bucket = bucket
    end

    def tag
      return if tagging.nil? || tagging[:tag_set].empty? # safeguard: dont overwrite current tags
      s3.put_bucket_tagging(bucket: @bucket, tagging: tagging)
    end

    # Merges existing tag_set structure so always appends tags, wont remove tags.
    # This behavior is consistent with the dynamodb tagging.
    #
    # Example return:
    #
    #     {
    #       tag_set: [
    #         { key: "Key1", value: "Value1" },
    #         { key: "Key2", value: "Value2" },
    #       ],
    #     }
    #
    def tagging
      c = TerraspacePluginAws::Interfaces::Config.instance.config
      tags = !c.s3.tags.empty? ? c.s3.tags : c.tags
      tag_set = tags.map do |k,v|
        {key: k.to_s, value: v}
      end
      return if tag_set == existing_tagging[:tag_set] # return nil so we can avoid the put_bucket_tagging call
      tag_set += existing_tagging[:tag_set]
      { tag_set: tag_set }
    end

    def existing_tagging
      s3.get_bucket_tagging(bucket: @bucket).to_h
    rescue Aws::S3::Errors::NoSuchTagSet
      {tag_set: []} # normalize return structure
    end
  end
end
