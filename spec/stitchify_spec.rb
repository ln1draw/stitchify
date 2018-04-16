require 'spec_helper'

describe "Stitchifier" do

    describe 'line methods' do
        it 'pos_slope_one gives expected vals' do
            s = Stitchifier.new
            expect(s.pos_slope_one(15, 35, 10)).to eq([15, 35, 25, 25])
            expect(s.pos_slope_one(15, 35, 15)).to eq([15, 35, 30, 20])
        end

        it 'neg_slope_one gives expected vals' do
            s = Stitchifier.new
            expect(s.neg_slope_one(15, 35, 10)).to eq([15, 35, 25, 45])
            expect(s.neg_slope_one(15, 35, 15)).to eq([15, 35, 30, 50])
        end

        it 'vertical_line' do
            s = Stitchifier.new
            expect(s.vertical_line(25, 5, 30)).to eq([25, 5, 25, 35])
            expect(s.vertical_line(25, 5, 15)).to eq([25, 5, 25, 20])
        end

        it 'horizontal_line' do
            s = Stitchifier.new
            expect(s.horizontal_line(5, 15, 30)).to eq([5, 15, 35, 15])
        end
    end
    # .~:+=o*x^%#@$MW

    describe 'char_builder' do
        describe 'takes letters and returns arrays of numbers' do
            before(:all) do
                @s = Stitchifier.new
            end

            it 'takes .' do
                expect(@s.char_builder('.')).to eq([[15, 35, 25, 25], [15, 25, 25, 35]])
            end
            
            it 'takes ~' do
                expect(@s.char_builder('~')).to eq([[5, 25, 15, 15], [15, 15, 25, 25], [25, 25, 35, 15]])
            end
            
            it 'takes :' do
                expect(@s.char_builder(':')).to eq(  [[15, 35, 25, 25], [15, 25, 25, 35], [15, 15, 25, 5], [15, 5, 25, 15]])
            end

            it 'takes +' do
                expect(@s.char_builder('+')).to eq([[25, 5, 25, 35], [5, 15, 35, 15]])
            end

            it 'takes =' do
                expect(@s.char_builder('=')).to eq([[5, 15, 35, 15], [5, 25, 35, 25]])
            end

            it 'takes o' do
                expect(@s.char_builder('o')).to eq([[5,  15, 15, 5],
                                                    [15, 5,  25, 5],
                                                    [25, 5,  35, 15],
                                                    [35, 15, 35, 25],
                                                    [25, 35, 35, 25],
                                                    [15, 35, 25, 35],
                                                    [5,  25, 15, 35],
                                                    [5,  15, 5,  25]])
            end

            it 'takes *' do
                expect(@s.char_builder('*')).to eq([[5, 35, 35, 5], [5, 5, 35, 35], [25, 5, 25, 35]])
            end

            it 'takes x' do
                expect(@s.char_builder('x')).to eq([[5, 35, 35, 5], [5, 5, 35, 35]])
            end

            it 'takes ^' do
                expect(@s.char_builder('^')).to eq([[15, 15, 25, 5], [25, 5, 35, 15]])
            end

            it 'takes %' do
                expect(@s.char_builder('%')).to eq([[5, 15, 15, 5], [5, 5, 15, 15], [5, 35, 35, 5], [25, 35, 35, 25], [25, 25, 35, 35]])
            end

            it 'takes #' do
                expect(@s.char_builder('#')).to eq([[15, 5, 15, 35], [25, 5, 25, 35], [5, 15, 35, 15], [5, 25, 35, 25]])
            end

            it 'takes @' do
                expect(@s.char_builder('@')).to eq([[25, 25, 35, 15],
                                                    [25, 15, 35, 25],
                                                    [35,  5, 35, 25],
                                                    [15,  5, 35,  5],
                                                    [5,  25, 15,  5],
                                                    [5,  25, 15, 35],
                                                    [15, 35, 35, 35]])
            end

            it 'takes $' do
                expect(@s.char_builder('$')).to eq([[15, 15, 25,  5],
                                                    [25,  5, 35, 15],
                                                    [15, 15, 35, 25],
                                                    [25, 35, 35, 25],
                                                    [15, 25, 25, 35],
                                                    [25,  5, 25, 35]])
            end

            it 'takes M' do
                expect(@s.char_builder('M')).to eq([[15, 5, 15, 35], [15, 5, 25, 25], [25, 25, 35, 5], [35, 5, 35, 35]])
            end

            it 'takes W' do
                expect(@s.char_builder('W')).to eq([[15, 5, 15, 35], [15, 35, 25, 15], [25, 15, 35, 35], [35, 5, 35, 35]])
            end

            it 'takes |' do
                expect(@s.char_builder('|')).to eq([[25, 5, 25, 35]])
            end

            it 'takes _' do
                expect(@s.char_builder('-')).to eq([[5, 25, 35, 25]])
            end

        end
        it 'can be changed by changing the pixel size' do
            @s = Stitchifier.new
            @s.px = 20
            expect(@s.char_builder('.')).to eq([[30, 70, 50, 50], [30, 50, 50, 70]])
        end
    end

    describe 'line_builder' do
        it 'takes a full line and returns an array of arrays' do
            s = Stitchifier.new
            expect(s.line_builder('.~')).to eq([[15, 35, 25, 25], [15, 25, 25, 35], [45, 25, 55, 15], [55, 15, 65, 25], [65, 25, 75, 15]])
        end
    end

    # describe 'paragraph_builder' do
    #     it 'takes a multiline string and calls line builder on each one' do
    #         s = Stitchifier.new
    #         expect(s.paragraph_builder("WM\n$%")).to eq([[15, 5, 15, 35],
    #                                                      [15, 35, 25, 15],
    #                                                      [25, 15, 35, 35],
    #                                                      [35, 5, 35, 35],
    #                                                      [55, 5, 55, 35],
    #                                                      [55, 5, 65, 25],
    #                                                      [65, 25, 75, 5],
    #                                                      [75, 5, 75, 35],
    #                                                      [95, 15, 105, 5],
    #                                                      [105, 5, 115, 15],
    #                                                      [95, 15, 115, 25],
    #                                                      [105, 35, 115, 25],
    #                                                      [95, 25, 105, 35],
    #                                                      [105, 5, 105, 35],
    #                                                      [125, 15, 135, 5],
    #                                                      [125, 5, 135, 15],
    #                                                      [125, 35, 155, 5],
    #                                                      [145, 35, 155, 25],
    #                                                      [145, 25, 155, 35]])
    #     end
    # end

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
    # describe 'instance method' do
    #     describe 'get_doc' do
    #         it 'returns a Nokogiri doc object when given a valid html string' do
    #             stitcher = Stitchifier.new()
    #             ret = stitcher.get_doc("<html><body><h1>Hello</h1></body></html>")
    #             expect(ret.class).to be(Nokogiri::HTML::Document)
    #         end

    #         it 'returns a Nokogiri doc object when given a valid link' do
    #             stitcher = Stitchifier.new()
    #             ret = stitcher.get_doc("http://www.google.com")
    #         end
    #     end

    #     describe 'build_links_array' do
    #         before(:all) do
    #             @html_str = "<html><body><a href='example.com'>A</a></body></html>"
    #         end

    #         it 'returns an array of arrays' do
    #             stitcher = Stitchifier.stitch(@html_str)
    #             ret = stitcher.get_doc(@html_str)
    #             stitcher.build_links_array
    #             expect(stitcher.links_array.class).to eq(Array)
    #             expect(stitcher.links_array[0].class).to eq(Array)
    #         end

    #         it 'returns A' do
    #             stitcher = Stitchifier.stitch("<html><body><a href='example.com'>A A</a></body></html>")
    #             ret = stitcher.get_doc(@html_str)
    #             stitcher.build_links_array
    #             expect(stitcher.links_array).to eq([[40, 120, 40, 40], [40, 80, 80, 80], [40, 40, 80, 40], [80, 120, 80, 40], [160, 120, 160, 40], [160, 80, 200, 80], [160, 40, 200, 40], [200, 120, 200, 40]])
    #         end
    #     end

    #     describe 'build_svg' do
    #         before(:each) do
    #             @html_str = "<html><body><a href='example.com'>A</a></body></html>"
    #             @stitcher = Stitchifier.stitch(@html_str)
    #             @stitcher.build_links_array
    #         end

    #         it 'returns an svg' do
    #             ret = @stitcher.build_svg
    #             expect(ret.class).to eq(Rasem::SVGImage)
    #         end
    #     end
    # end

    # describe 'class method' do
    #     describe 'stitch' do
    #         it 'returns a set stitcher' do
    #             stitcher = Stitchifier.stitch('http://www.google.com')
    #             expect(stitcher.title).to eq('Google')
    #         end

    #         it 'sets the links to eq a nokogiri xml nodeset of nokogiri xml elements' do
    #             stitcher = Stitchifier.stitch('http://www.google.com')
    #             expect(stitcher.links.class).to eq(Nokogiri::XML::NodeSet)
    #             expect(stitcher.links[0].class).to eq(Nokogiri::XML::Element)
    #         end
    #     end
    # end
end


    # def self.stitch(content)
    #     stitcher = Stitchifier.new()

    #     doc = stitcher.get_doc(content)
    #     stitcher.title = doc.title
    #     stitcher.links = doc.css('a')

    #     stitcher.build_links

    #     stitcher
    # end