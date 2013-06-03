class Array
  def comprehend &block
    return self unless block
    head, *tail = self.map(&:to_a)
    return head.map(&block).compact if tail.empty?
    return head.product(*tail).map(&block).compact
  end
end

def sieve list
  return [] if list.empty?
  [x = list.shift] + sieve([list].comprehend { |y| y if y % x != 0 })
end
