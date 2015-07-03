require 'spec_helper'

module TBlock
  describe GridLayout do
    it "should concatenate table of blocks into a single block" do
      t00 = TextBlock.new ['aaaaa']
      t01 = TextBlock.new ['bb', 'bb', 'bb']
      t02 = TextBlock.new ['ccc']
      t10 = TextBlock.new ['dd', 'dd', 'dd']
      t11 = TextBlock.new ['e', 'e']
      t12 = TextBlock.new ['fffff']
      t20 = TextBlock.new ['g', 'g', 'g']
      t21 = TextBlock.new ['hhhhh']
      t22 = TextBlock.new ['iii']

      table = [[t00, t01, t02], [t10, t11, t12], [t20, t21, t22]]

      grid = GridLayout.new(table, {
        align_h: :center,
        columns: {
          0 => {align_v: :top},
          2 => {align_v: :bottom},
        },
        lines: {
          3 => {align_h: :right},
        },
        cells: {
          [0, 1] => {align_h: :left},
          [0, 2] => {align_v: :center},
          [1, 0] => {align_h: :right},
          [2, 2] => {align_h: :right},
        },
      })

      expected = TextBlock.new ['aaaaabb        ',
                                '     bb    ccc ',
                                '     bb        ',
                                '   dd  e       ',
                                '   dd  e       ',
                                '   dd     fffff',
                                '  g            ',
                                '  g  hhhhh     ',
                                '  g         iii']

      expect(grid).to eq expected
    end

    describe ":separator_v" do
      it "should insert vertical separator between columns" do
        t1 = TextBlock.new ['aa',
                            'aa']
        t2 = TextBlock.new ['bb',
                            'bb']
        grid = GridLayout.new([[t1, t2]], {
          separator_v: 2
        })
        expected = TextBlock.new ['aa  bb',
                                  'aa  bb']
        expect(grid).to eq expected
      end
    end
  end
end
