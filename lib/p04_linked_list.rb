class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  def initialize
    @start = Link.new
    @end = Link.new
    @start.next = @end
    @end.prev = @start
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @start.next
  end

  def last
    @end.prev
  end

  def empty?
    @start.next == @end
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def insert(key, val)
    each do |link|
      next unless link.key == key
      link.val = val
      return
    end
    link = Link.new(key, val) # [D  L  D]
    last.next = link # [D  L  L  D]
    link.prev = last # [D  L  L   D]
    @end.prev = link #[D   L   L   D]
    link.next = @end
    link
  end

  def remove(key)
    each do |link|
      next unless link.key == key
      link.next.prev = link.prev
      link.prev.next = link.next
      return link.val
    end
  end

  def each(&prc)
    current_link = @start
    while current_link.next.key != nil
      current_link = current_link.next
      prc.call(current_link)
    end
    self
  end

  include Enumerable
  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
