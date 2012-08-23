# The stream data enumerator.
class Backdat::Data::Stream < Backdat::Data::Base
  # Path alias for the list of items.
  def path; @items end
end
