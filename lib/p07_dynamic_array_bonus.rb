class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @count
    return nil if i*-1 >= @count
    i = i % @count
    @store[i]
  end

  def []=(i, val)
    @count += 1 if @store[i].nil?
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! unless @count < @store.length
    self[@count] = val
  end

  def unshift(val)
    @count += 1
    resize! unless @count < @store.length
    buffer = [val]
    each do |el|
      buffer << el
    end
    @count = 0
    i = 0
    buffer.each do |el|
      @store[i] = el
      i += 1
    end
  end

  def pop
    return nil if count == 0
    val = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    val

  end

  def shift
    return nil if count == 0
    val = @store[0]
    i = 0
    each do |el|
      next if i == @store.length - 1
      @store[i] = @store[i+1]
    end
    @store[@count-1] = nil
    @count -= 1
    val
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  include Enumerable

  def each(&prc)
    @count.times do |idx|
      prc.call(@store[idx])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    i = 0
    each do |el|
      return false if el != other[i]
      i += 1
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    resized = StaticArray.new(@store.length * 2)
    i = 0
    each do |el|
      resized[i] = el
      i += 1
    end
    @store = resized
  end
end
