class Pixelfy
  require 'chroma'
  include Chroma

  attr_accessor :hue, :saturation, :lightness, :shape

  HSL_OPEN_CONST = "hsl("

  def initialize(hue, saturation, lightness, shape=nil)
    self.hue = hue
    self.saturation = saturation
    self.lightness = lightness
    self.shape = shape
  end

  def self.from_hex(hex_str)
    px = ''
    if hex_str
      color_str = Chroma::Color.new(hex_str).to_hsl
      color_str.slice!(HSL_OPEN_CONST)
      color_str.slice!("%)")
      color_str.slice!('%')
      color_arr = color_str.split(', ')

      px = self.new(color_arr[0].to_i, color_arr[1].to_i, color_arr[2].to_i)
    end
    px
  end

  def hex
    Chroma::Color.new(hsl).to_hex
  end

  def hsl
    "#{HSL_OPEN_CONST} #{self.hue}, #{self.saturation}%, #{self.lightness}%)"
  end

  def hsla
    "#{HSL_OPEN_CONST} #{self.hue}, #{self.saturation}%, #{self.lightness}%, 1)"
  end

  def name
    n = ''
    c = Chroma::Color.new(hsl).to_name
    n = c unless c == "<unknown>"

  end

  def colorize(map)
    deltae = 100000000000
    closest_px = map[0]

    map.each do |dom_px|
      dom_px_delta = self.get_delta_e(dom_px)
      current_px_delta = self.get_delta_e(closest_px)
      if dom_px_delta < current_px_delta
          deltae = dom_px_delta
          closest_px = dom_px
      end
    end

    self.hue = closest_px.hue
    self.saturation = closest_px.saturation
    self.lightness = closest_px.lightness
    self.shape = closest_px.shape

    self
  end

  def get_delta_e(px)
    hue_delta = (px.hue - self.hue).abs
    sat_delta = (px.saturation - self.saturation).abs
    lit_delta = (px.lightness - self.lightness).abs

    hue_delta + sat_delta + lit_delta
  end
end
