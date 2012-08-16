# The base backdat storage class.
class Backdat::Storage
  def initialize
  end

  def name
    unless self.class == "Backdat::Storage"
  end
end

_storage_dir = File.join(File.dirname(__FILE__), "storage")
$:.unshift _storage_dir
Dir.glob("#{_storage_dir}/*").each do |s|
  require "backdat/storage/#{File.basename(s)}"
end
