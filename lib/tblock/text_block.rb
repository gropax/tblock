module TBlock
  class TextBlock
    TextBlockError = Class.new StandardError

    def self.blank(h, w)
      self.new [' '*w]*h
    end

    attr_reader :lines
    def initialize(lines = [])
      @width = lines.map(&:length).max || 0
      @lines = lines.map { |l| l.ljust(width) }
    end

    def ==(other)
      @lines.size == other.lines.size && [@lines, other.lines].transpose.all? { |l1, l2| l1 == l2 }
    end

    def height
      @lines.size
    end

    def width
      @width
    end

    def center(n); fmap { |l| l.center(n) } end
    def ljust(n);  fmap { |l| l.ljust(n) } end
    def rjust(n);  fmap { |l| l.rjust(n) } end

    def fmap(&blk)
      TextBlock.new(@lines.map { |l| yield l })
    end

    def vcenter(n)
      vjust(n) do |i, l|
        above = i / 2
        below = i - above
        lines = [l]*above + @lines + [l]*below
      end
    end

    def ujust(n)
      vjust(n) { |i, l| @lines + [l]*i }
    end

    def djust(n)
      vjust(n) { |i, l| [l]*i + @lines }
    end

    def vjust(n)
      add = n - height
      if add <= 0 then dup else
        line = " " * width
        lines = yield add, line
        TextBlock.new(lines)
      end
    end

    def concat!(other)
      if self.height != other.height
        raise TextBlockError, "Text blocks must have the same height."
      end
      lines = [@lines, other.lines].transpose.map { |l1, l2| l1 + l2 }
      TextBlock.new lines
    end

    def concat(other)
      h = [self, other].map(&:height).max
      self.vcenter(h).concat!(other.vcenter h)
    end
    alias_method :+, :concat

    def vconcat!(other)
      if self.width != other.width
        raise TextBlockError, "Text blocks must have the same width."
      end
      TextBlock.new(@lines + other.lines)
    end

    def vconcat(other)
      w = [self, other].map(&:width).max
      self.center(w).vconcat!(other.center w)
    end
    alias_method :/, :vconcat

    def to_s
      @lines.join("\n")
    end

    def inspect
      to_s
    end
  end
end
