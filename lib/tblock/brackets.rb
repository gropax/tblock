module TBlock
  class Brackets
    DEFAULT_OPTIONS = {
      wrap_top: true,
      wrap_bottom: true,
    }

    def initialize(tblock, opts = {})
      @block = tblock
      @options = opts
    end

    def build
      h = @block.height
      if wrap_all?
        left_bracket(h) + @block + right_bracket(h)
      elsif wrap_none?
        left_bracket(h-2) + @block + right_bracket(h-2)
      elsif !wrap_top?
        left_bracket(h-1) + @block + right_bracket(h-1)
      elsif !wrap_bottom?
        left_bracket(h-1) + @block.djust(h+1) + right_bracket(h-1)
      end
    end

    private

      def wrap_none?
        !wrap_top? && !wrap_bottom?
      end

      def wrap_all?
        wrap_top? && wrap_bottom?
      end

      def wrap_top?
        options(:wrap_top) == true
      end

      def wrap_bottom?
        options(:wrap_bottom) == true
      end

      def options(key)
        @options[key].nil? ? DEFAULT_OPTIONS[key] : @options[key]
      end

      def left_bracket(h)
        TextBlock.new (["│"]*h).unshift("┌").push("└")
      end

      def right_bracket(h)
        TextBlock.new (["│"]*h).unshift("┐").push("┘")
      end
  end
end
