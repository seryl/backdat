# A data enumerator for the backdat formats.
class Backdat::Data
  def initialize
  end

  # Yields either the next file or stream based on the format.
  def next
    yield
  end
end
