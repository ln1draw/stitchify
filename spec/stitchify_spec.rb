require 'spec_helper'

describe "Stitchifier" do
    URL = 'http://www.ellenwondra.com/MYFACE.jpg'

    describe 'initialize' do
        it 'accepts empty params' do
            s = Stitchifier.new
            expect(s).to be_truthy
        end

        it 'does not set img with empty img_path' do
            s = Stitchifier.new
            expect(s.img).to be_falsy
        end

        it 'accepts real params' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.img_path).to eq(URL)
            expect(s.width).to be(30)
            expect(s.num_of_colors).to be(5)
        end

        it 'sets an img with existing img_path' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.img).to be_truthy
        end
    end

    describe 'set_num_colors' do
        it 'sets the number of colors in Miro' do
            s = Stitchifier.new
            expect(s.view_miro_opts[:color_count]).to be(8)
            s.set_num_colors(4)
            expect(s.set_num_colors(4))
        end
    end

    describe 'set_dominant_colors' do
        it 'returns an array of just black and white if it cannot successfully extract colors' do
            s = Stitchifier.new
            s.set_dominant_colors

            expect(s.dominant_colors.length).to be(2)
        end

        it 'sets the dominant_colors array' do
            s = Stitchifier.new(URL, 30, 5)
            s.set_dominant_colors

            expect(s.dominant_colors.length).to be(7)
        end
    end

    describe 'get_pixels' do
        it 'gets an array of pixel data' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.get_pixels.length).to be(900)
        end

        it 'provides color codes' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.get_pixels[0]).to eq([62.104442712392824, 67.47061249742194, 245.56614785992218, 1.0])
        end
    end

    describe 'hex_to_hsla' do
        it 'returns an expected array of hsla data' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.hex_to_hsla('#ffffff')).to eq([0, 0, 100, 1])
        end
    end

    describe 'colorize_pixel' do
        it 'takes a specific pixel and returns its closest match from the dominant colors' do
            s = Stitchifier.new(URL, 30, 5)
            px = s.get_pixels[0]
            expect(s.colorize_pixel(px)).to eq('foo')
        end
    end
end


#     def make_grid
#         # builds cross stitch grid
#     end

#     def make_pattern
#         # builds cross stitch pattern
#     end

# img_to_stitchify = cat.quantize(num_of_colors).resize_to_fit(width)
# img_to_stitchify.display
# colors = []
# img_to_stitchify.each_pixel do | pixel, col, row |
#   colors << Chroma.paint("hsla(#{pixel.to_hsla.to_s[1..-2]})")
# end