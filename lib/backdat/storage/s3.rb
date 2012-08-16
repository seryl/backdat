# The backdat S3 storage object.
class Backdat::Storage::S3 < Backdat::Storage
  attr_reader :aws_accsss_key, :aws_access_secret

  # The bucket
  attr_reader :bucket, :path

end
