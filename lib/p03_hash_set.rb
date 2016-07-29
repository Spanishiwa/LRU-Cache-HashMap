require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      resize! if num_buckets == @count
      self[key] << key
      @count += 1
    end
    key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
    key
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    resized = Array.new(@count * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |key|
        resized[key.hash % resized.size] << key
      end
    end
    @store = resized
  end
end
