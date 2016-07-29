class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    (self.map(&:hash).to_s+"Array").bytes.join.to_i

  end
end

class String
  def hash
    (self + "String").bytes.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (self.sort.map(&:hash).to_s + "Hash").bytes.join.to_i
  end
end
