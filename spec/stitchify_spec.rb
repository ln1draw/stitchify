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
            s = Stitchifier.new(URL, 30, 5, 5)
            expect(s.img_path).to eq(URL)
            expect(s.width).to eq(30)
            expect(s.num_of_colors).to eq(5)
        end

        it 'sets an img with existing img_path' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.img).to be_truthy
        end
    end

    describe 'set_dominant_colors' do
        it 'returns an array of just black and white if it cannot successfully extract colors' do
            s = Stitchifier.new
            s.set_dominant_colors

            expect(s.dominant_colors.length).to eq(2)
        end

        it 'sets the dominant_colors array' do
            s = Stitchifier.new(URL, 30, 5, 7)
            s.set_dominant_colors

            expect(s.dominant_colors.length).to eq(7)
        end
    end

    describe 'build_color_set' do
        it 'sets color_set to dominant colors when nothing else is specified' do
            s = Stitchifier.new(URL, 30, 5, 4)
            s.build_color_set
            hex_map = s.color_set.map{ |x| x.hex }

            expect(hex_map).to eq(["#432b23", "#233b43", "#000000", "#ffffff"])
        end

        it 'sets color_set to dominant colors plus color set when passed color set params' do 
            s = Stitchifier.new(URL, 30, 5, 4)
            s.build_color_set(['#00ff00'])
            hex_map = s.color_set.map{ |x| x.hex }

            expect(hex_map.sort).to eq(["#00ff00", "#233b43", "#000000", "#ffffff"].sort)
        end
    end

    describe 'get_pixels' do
        it 'gets an array of pixel data' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.get_pixels.length).to eq(900)
        end

        it 'provides color codes' do
            s = Stitchifier.new(URL, 30, 5)
            expect(s.get_pixels[0].class).to eq(Pixelfy)
        end
    end
end