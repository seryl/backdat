# A data enumerator for the backdat formats.
class Backdat::Data
  attr_reader :format

  # Creates a new data enumerator.
  # 
  # @param [ Array ] path The list of path items for the enumerator.
  # @param [ Symbol ] format The enumerator format.
  def initialize(path=[], format=:file)
    @path = path
    @format = format
  end

  # Yields either the next file or stream based on the format.
  def next
    yield
  end
end
