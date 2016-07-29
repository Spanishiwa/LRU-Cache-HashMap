require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    each { |link_key, _| return true if key == link_key }
    false
  end

  def set(key, val)
    resize! if @count == num_buckets
    bucket(key).insert(key, val)
    @count += 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.reverse.each do |linklist|
      linklist.each do |link|
        prc.call(link.key, link.val)
      end
    end
    self
  end
  include Enumerable
  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    resized = Array.new(num_buckets * 2) { LinkedList.new }
    each do |key, val|
      resized[key.hash % resized.size].insert(key, val)
    end
    @store = resized
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
