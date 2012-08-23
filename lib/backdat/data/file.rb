# The file data enumerator.
class Backdat::Data::File < Backdat::Data::Base
  # Path alias for the list of items.
  def path; @items end
end
