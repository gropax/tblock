require 'spec_helper'

module TBlock
  describe TextBlock do
    let(:block) { TextBlock.new [ 'aaaa',
                                  'bbbb',
                                  'cccc'] }
    describe "::blank" do
      it "should return a new blank text block" do
      end
    end

    describe "#==" do
      it "should return true if blocks have eq lines" do
        other = TextBlock.new [ 'aaaa', 'bbbb', 'cccc']
        expect(block == other).to be true
      end
    end

    describe "#height" do
      it "should return the line number" do
        expect(block.height).to be 3
      end
    end

    describe "#width" do
      it "should return the maximum line length" do
        expect(block.width).to be 4
      end
    end

    describe "concatenation" do
      describe "#concat!" do
        it "should concatenate horizontally two block of same height" do
          given = TextBlock.new [ 'eee',
                                  'fff',
                                  'ggg']
          expected = TextBlock.new [ 'aaaaeee',
                                     'bbbbfff',
                                     'ccccggg']
          expect(block.concat! given).to eq expected
        end

        it "should raise error if block of different height" do
          given = TextBlock.new [ 'eee',
                                  'ggg']
          expect { block.concat! given }.to raise_error(TextBlock::TextBlockError)
        end
      end

      describe "#concat" do
        it "should concatenate horizontally two block of different size" do
          given = TextBlock.new [ 'eee',
                                  'fff',
                                  'ggg',
                                  'hhh',
                                  'iii']
          expected = TextBlock.new [ '    eee',
                                     'aaaafff',
                                     'bbbbggg',
                                     'cccchhh',
                                     '    iii']
          expect(block.concat given).to eq expected
        end
      end

      describe "#vconcat!" do
        it "should concatenate vertically two blocks of same width" do
          given = TextBlock.new [ 'eeee',
                                  'ffff']
          expected = TextBlock.new [ 'aaaa',
                                     'bbbb',
                                     'cccc',
                                     'eeee',
                                     'ffff']
          expect(block.vconcat! given).to eq expected
        end

        it "should raise error if blocks of different width" do
          given = TextBlock.new [ 'eee',
                                  'ggg']
          expect { block.vconcat! given }.to raise_error(TextBlock::TextBlockError)
        end
      end

      describe "#vconcat" do
        it "should concatenate vertically two blocks of different size" do
          given = TextBlock.new [ 'eeeeee',
                                  'ffffff']
          expected = TextBlock.new [ ' aaaa ',
                                     ' bbbb ',
                                     ' cccc ',
                                     'eeeeee',
                                     'ffffff']
          expect(block.vconcat given).to eq expected
        end
      end
    end

    describe "justification" do
      describe "#center" do
        it "should add spaces on both side of the block" do
          expected = TextBlock.new [ '   aaaa   ',
                                     '   bbbb   ',
                                     '   cccc   ']
          expect(block.center 10).to eq expected
        end
      end

      describe "#ljust" do
        it "should add spaces on the right side of the block" do
          expected = TextBlock.new [ 'aaaa      ',
                                     'bbbb      ',
                                     'cccc      ']
          expect(block.ljust 10).to eq expected
        end
      end

      describe "#rjust" do
        it "should add spaces on the left side of the block" do
          expected = TextBlock.new [ '      aaaa',
                                     '      bbbb',
                                     '      cccc']
          expect(block.rjust 10).to eq expected
        end
      end

      describe "#vcenter" do
        it "should add blank lines above and below the block" do
          expected = TextBlock.new [ '    ',
                                     'aaaa',
                                     'bbbb',
                                     'cccc',
                                     '    ']
          expect(block.vcenter 5).to eq expected
        end
      end

      describe "#ujust" do
        it "should add blank lines below the block" do
          expected = TextBlock.new [ 'aaaa',
                                     'bbbb',
                                     'cccc',
                                     '    ',
                                     '    ']
          expect(block.ujust 5).to eq expected
        end
      end

      describe "#djust" do
        it "should add blank lines above the block" do
          expected = TextBlock.new [ '    ',
                                     '    ',
                                     'aaaa',
                                     'bbbb',
                                     'cccc']
          expect(block.djust 5).to eq expected
        end
      end
    end
  end
end
