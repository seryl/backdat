# A grouping of links to describe a backdat procedure.
class Backdat::Chain < Backdat::Link
  attr_accessor :root, :tail

  def initialize
    @root = nil
    @tail = nil
  end

  # Adds a link onto the backdat chain.
  # 
  # @param [ Backdat::Link ] link The link to add onto the chain.
  def add(link)
     @root = link if @root.nil?
     if @tail
      @tail.next = link
      link.before = @tail
     end
     @tail = link
  end

  # Searches through the chain for a given link.
  # 
  # @param [ Backdat::Link ] link The link to search for.
  # 
  # @return [ Backdat::Link ] The link that matches the search.
  def find(link)
    _link = @root
    until(_link == nil or _link == link)
      _link = _link.next
    end
    _link
  end

  # Removes a link from the chain.
  # 
  # @param [ Backdat::Link ] link The link to remove.
  def remove(link)
    _link = find(link)
    return if _link.nil?
    _link.before.next = _link.next
    @tail = _link.before if @tail == link
  end
end
