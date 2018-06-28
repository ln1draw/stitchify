require 'spec_helper'

describe 'Pixelfy' do
  describe 'colorize_from_map' do
    before(:each) do
      @map = [
        Pixelfy.new(0, 0, 0),
        Pixelfy.new(60, 100, 40),
        Pixelfy.new(221, 50, 60),
        Pixelfy.new(221, 52, 60),
        Pixelfy.new(7, 24, 2)
      ]
    end

    it 'updates the color of the pixel to the closest color from a map' do
      px = Pixelfy.new(66, 100, 50)
      expect(px.hex).to eq('#e6ff00')
      
      px.colorize(@map)
      expect(px.hex).to eq("#cccc00")
    end

    it 'updates the color to the appropriate color if two colors are both very close' do
      px = Pixelfy.new(225, 100, 50)
      expect(px.hex).to eq('#0040ff')

      px.colorize(@map)
      expect(px.hex).to eq('#6486ce')
    end
  end
end