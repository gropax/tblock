module TBlock
  # @example
  #   GridLayout.new(..., {
  #     valign: :center,
  #     halign: :center,
  #     lines: {
  #       0 => {align_v: :center, align_h: :left}
  #     }
  #     columns: {0 => ...},
  #     cells: {[1,2] => ...}
  #   }
  class GridLayout < TextBlock
    DEFAULT_OPTIONS = {
      align_h: :left,
      align_v: :center,
    }

    def initialize(table, opts = {})
      @table = table
      @options = opts

      super(build_lines)
    end

    private

      def build_lines
        tblock = @table.each_with_index.map { |line, i|
          lines = line.each_with_index.map { |cell, j|
            c = align_h(cell, options_for(i, j, :align_h), column_width(j))
            align_v(c, options_for(i, j, :align_v), line_height(i))
          }
          if w = @options[:separator_v]
            lines.reduce { |blk, line| blk + TextBlock.blank(line_height(i), w) + line }
          else
            lines.reduce(:+)
          end
        }.reduce(:/)

        tblock.lines
      end

      def align_h(block, mode, width)
        case mode
        when :left then block.ljust(width)
        when :right then block.rjust(width)
        when :center then block.center(width)
        else
          raise TypeError, "Unknown value #{mode} for option `align_h`"
        end
      end

      def align_v(block, mode, height)
        case mode
        when :top then block.ujust(height)
        when :bottom then block.djust(height)
        when :center then block.vcenter(height)
        else
          raise TypeError, "Unknown value #{mode} for option `align_v`"
        end
      end

      def line_height(i)
        @line_heights ||= @table.map { |line| line.map { |c| c.height }.max }
        @line_heights[i]
      end

      def column_width(i)
        @column_widths ||= @table.transpose.map { |col| col.map { |c| c.width }.max }
        @column_widths[i]
      end

      def options_for(i, j, key)
        special_option(:cells, key, [i, j]) ||
          special_option(:lines, key, i) ||
          special_option(:columns, key, j) ||
          @options[key] ||
          DEFAULT_OPTIONS[key]
      end

      def special_option(type, key, id)
        opts = @options[type]
        opts && opts[id] && opts[id][key]
      end
  end
end
