module TerraspacePluginAws::Interfaces
  class Ci
    # interface method
    def vars
      {
        AWS_ACCESS_KEY_ID: '${{ secrets.AWS_ACCESS_KEY_ID }}',
        AWS_SECRET_ACCESS_KEY: '${{ secrets.AWS_SECRET_ACCESS_KEY }}',
        AWS_REGION: AwsData.new.region,
      }
    end
  end
end
