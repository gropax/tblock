require 'spec_helper'

module TBlock
  describe Brackets do
    describe "#build" do
      it "should return the given block inside brackets" do
        block = TextBlock.new [ 'aaaa',
                                'bbbb',
                                'cccc']

        expected = TextBlock.new [ '┌    ┐',
                                   '│aaaa│',
                                   '│bbbb│',
                                   '│cccc│',
                                   '└    ┘']
        brackets = Brackets.new(block).build

        expect(brackets).to eq expected
      end
    end

    describe ":wrap_top" do
      it "should return brackets close to the top" do
        block = TextBlock.new [ 'aaaa',
                                'bbbb',
                                'cccc']

        expected = TextBlock.new [ '┌aaaa┐',
                                   '│bbbb│',
                                   '│cccc│',
                                   '└    ┘']
        brackets = Brackets.new(block, wrap_top: false).build

        expect(brackets).to eq expected
      end
    end

    describe ":wrap_bottom" do
      it "should return brackets close to the top" do
        block = TextBlock.new [ 'aaaa',
                                'bbbb',
                                'cccc']

        expected = TextBlock.new [ '┌    ┐',
                                   '│aaaa│',
                                   '│bbbb│',
                                   '└cccc┘']
        brackets = Brackets.new(block, wrap_bottom: false).build

        expect(brackets).to eq expected
      end
    end

    describe ":wrap_top & :wrap_bottom" do
      it "should return brackets close to the top" do
        block = TextBlock.new [ 'aaaa',
                                'bbbb',
                                'cccc']

        expected = TextBlock.new [ '┌aaaa┐',
                                   '│bbbb│',
                                   '└cccc┘']
        brackets = Brackets.new(block, wrap_top: false, wrap_bottom: false).build

        expect(brackets).to eq expected
      end
    end
  end
end
