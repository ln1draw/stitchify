require 'spec_helper'

describe "Stitchifier" do

    describe 'line methods' do
        it 'pos_slope_one gives expected vals' do
            s = Stitchifier.new
            expect(s.pos_slope_one(15, 35, 10, '#000000')).to eq([15, 35, 25, 25, '#000000'])
            expect(s.pos_slope_one(15, 35, 15, '#000000')).to eq([15, 35, 30, 20, '#000000'])
        end

        it 'neg_slope_one gives expected vals' do
            s = Stitchifier.new
            expect(s.neg_slope_one(15, 35, 10, '#000000')).to eq([15, 35, 25, 45, '#000000'])
            expect(s.neg_slope_one(15, 35, 15, '#000000')).to eq([15, 35, 30, 50, '#000000'])
        end

        it 'vertical_line' do
            s = Stitchifier.new
            expect(s.vertical_line(25, 5, 30, '#000000')).to eq([25, 5, 25, 35, '#000000'])
            expect(s.vertical_line(25, 5, 15, '#000000')).to eq([25, 5, 25, 20, '#000000'])
        end

        it 'horizontal_line' do
            s = Stitchifier.new
            expect(s.horizontal_line(5, 15, 30, '#000000')).to eq([5, 15, 35, 15, '#000000'])
        end
    end
    # .~:+=o*x^%#@$MW

    describe 'char_builder' do
        describe 'takes letters and returns arrays of numbers' do
            before(:all) do
                @s = Stitchifier.new
            end

            it 'takes .' do
                expect(@s.char_builder('.', '#000000')).to eq([[15, 25, 25, 15, "#000000"], [15, 15, 25, 25, "#000000"]])
            end
            
            it 'takes ~' do
                expect(@s.char_builder('~', '#000000')).to eq([
                    [-5, 25, 5, 15, "#000000"],
                    [5, 15, 15, 25, "#000000"],
                    [15, 25, 25, 15, "#000000"]
                ])
            end
            
            it 'takes :' do
                expect(@s.char_builder(':', '#000000')).to eq([
                    [15, 25, 25, 15, "#000000"],
                    [15, 15, 25, 25, "#000000"],
                    [15, 15, 25, 5, "#000000"],
                    [15, 5, 25, 15, "#000000"]
                ])
            end

            it 'takes +' do
                expect(@s.char_builder('+', '#000000')).to eq([[15, 5, 15, 25, "#000000"], [5, 15, 25, 15, "#000000"]])
            end

            it 'takes =' do
                expect(@s.char_builder('=', '#000000')).to eq([[5, 15, 25, 15, '#000000'], [5, 25, 25, 25, '#000000']])
            end

            it 'takes o' do
                expect(@s.char_builder('o', '#000000')).to eq([
                    [5, 15, 15, 5, "#000000"],
                    [15, 5, 25, 15, "#000000"],
                    [15, 25, 25, 15, "#000000"],
                    [5, 15, 15, 25, "#000000"]
                ])
            end

            it 'takes *' do
                expect(@s.char_builder('*', '#000000')).to eq([
                    [5, 25, 25, 5, "#000000"],
                    [5, 5, 25, 25, "#000000"],
                    [15, 5, 15, 25, "#000000"]
                ])
            end

            it 'takes x' do
                expect(@s.char_builder('x', '#000000')).to eq([[5, 25, 25, 5, "#000000"], [5, 5, 25, 25, "#000000"]])
            end

            it 'takes ^' do
                expect(@s.char_builder('^', '#000000')).to eq([[5, 15, 15, 5, "#000000"], [15, 5, 25, 15, "#000000"]])
            end

            it 'takes %' do
                expect(@s.char_builder('%', '#000000')).to eq([
                    [5, 15, 15, 5, "#000000"],
                    [5, 5, 15, 15, "#000000"],
                    [5, 25, 25, 5, "#000000"],
                    [15, 25, 25, 15, "#000000"],
                    [15, 15, 25, 25, "#000000"]
                ])
            end

            it 'takes #' do
                expect(@s.char_builder('#', '#000000')).to eq([
                    [5, 25, 15, 5, "#000000"],
                    [15, 25, 25, 5, "#000000"],
                    [5, 15, 25, 15, "#000000"],
                    [5, 25, 25, 25, "#000000"]
                ])
            end

            it 'takes @' do
                expect(@s.char_builder('@', '#000000')).to eq([
                    [15, 25, 25, 15, "#000000"],
                    [15, 15, 25, 25, "#000000"],
                    [25, 5, 25, 25, "#000000"],
                    [15, 5, 25, 5, "#000000"],
                    [5, 15, 15, 5, "#000000"],
                    [5, 15, 15, 25, "#000000"],
                    [15, 25, 25, 25, "#000000"]
                ])
            end

            # output << pos_slope_one(1.5 * px,   2.5 * px, px, hex_str)
            #         output << neg_slope_one(1.5 * px,   1.5 * px, px, hex_str)
            #         output << vertical_line(2.5 * px,   px / 2,   2 * px, hex_str)
            #         output << horizontal_line(1.5 * px, px / 2,   px, hex_str)
            #         output << pos_slope_one(px / 2,     1.5 * px, px, hex_str)
            #         output << neg_slope_one(px / 2,     1.5 * px, px, hex_str)
            #         output << horizontal_line(1.5 * px, 2.5 * px, px, hex_str)

            it 'takes $' do
                expect(@s.char_builder('$', '#000000')).to eq([
                    [5, 5, 25, 5, "#000000"],
                    [5, 5, 25, 25, "#000000"],
                    [5, 25, 25, 25, "#000000"],
                    [15, 5, 15, 25, "#000000"]
                ])
            end

            it 'takes M' do
                expect(@s.char_builder('M', '#000000')).to eq([
                    [5, 5, 5, 25, "#000000"],
                    [5, 5, 15, 15, "#000000"],
                    [15, 15, 25, 5, "#000000"],
                    [25, 5, 25, 25, "#000000"]
                ])
            end

            it 'takes W' do
                expect(@s.char_builder('W', '#000000')).to eq([
                    [5, 5, 5, 25, "#000000"],
                    [5, 25, 15, 15, "#000000"],
                    [15, 15, 25, 25, "#000000"],
                    [25, 5, 25, 25, "#000000"]
                ])
            end

            it 'takes |' do
                expect(@s.char_builder('|', '#000000')).to eq([[25, 5, 25, 25, '#000000']])
            end

            it 'takes _' do
                expect(@s.char_builder('-', '#000000')).to eq([[5, 25, 25, 25, '#000000']])
            end

        end
        it 'can be changed by changing the pixel size' do
            @s = Stitchifier.new
            @s.px = 20
            expect(@s.char_builder('.', '#000000')).to eq([[30, 50, 50, 30, "#000000"], [30, 30, 50, 50, "#000000"]])
        end
    end

    describe 'line_builder' do
        it 'takes a full line and returns an array of arrays' do
            s = Stitchifier.new
            expect(s.line_builder('.~')).to eq([
                [15.0, 25.0, 25.0, 15.0, "#000000"],
                [15.0, 15.0, 25.0, 25.0, "#000000"],
                [15, 25.0, 25, 15.0, "#000000"],
                [25, 15.0, 35, 25.0, "#000000"],
                [35.0, 25.0, 45.0, 15.0, "#000000"]
            ])
        end
    end


    describe 'svg_output' do
        it 'takes an array of arrays and returns an svg' do
        end
        it 'returns different values for different pixel sizes' do
        end
        it 'includes lines for the canvas' do
        end
    end

    describe 'stitch' do
        it 'takes an image and returns an svg' do
        end
    end
  
end