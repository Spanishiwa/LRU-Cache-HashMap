require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    link = @map[key]
    if link
      update_link!(link)
      link.val
    else
      eject! if count >= @max
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @store.insert(key, val)
    link = @store.last
    @map.set(key, link)
    val
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end
