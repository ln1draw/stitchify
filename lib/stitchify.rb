require 'chroma'
require 'color'
require 'miro'
require 'pry'
require 'rasem'
require 'RMagick'

require 'stitchify/draw_rasem'

class Stitchifier
    include Chroma
    include Magick
    include Miro

    HSLA_BLACK = [0, 0, 0, 1]
    HSLA_WHITE = [0, 0, 100, 1]
    HSL_OPEN_CONST = "hsl("

    attr_accessor :base_pixel_arr,
                  :dominant_colors,
                  :img,
                  :img_path,
                  :num_of_colors,
                  :pos_x,
                  :pos_y,
                  :px,
                  :stitch_map,
                  :width

    def initialize(img_path = '', width = 50, px=10, num_of_colors = 8)
        # sets variables
        set_num_colors(num_of_colors)
        self.num_of_colors = num_of_colors
        self.width = width
        self.num_of_colors = num_of_colors
        self.img_path = img_path
        self.dominant_colors = []
        self.stitch_map = []
        self.px = px

        unless img_path.empty?
            make_img
            set_dominant_colors
            build_pixel_array
            d = DrawRasem.new(self.stitch_map, self.width, self.px)
            d.stitch
        end
    end

    def make_img
        self.img = ImageList.new(img_path).quantize.resize_to_fit(width)
    end

    def set_dominant_colors
        colors = [HSLA_BLACK, HSLA_WHITE]
        miro_data = Miro::DominantColors.new(self.img_path).to_hex unless self.img_path.empty?
        miro_data.each{ |x| colors << hex_to_hsla(x) } unless miro_data.nil?
        self.dominant_colors = colors
    end

    def build_pixel_array
        get_pixels
        colorize_pixels
    end

    def get_pixels
        px = []

        unless self.img.nil?
            self.img.each_pixel do | pixel, col, row |
                px << pixel.to_hsla
            end
        end
        self.base_pixel_arr = px
        px
    end

    def colorize_pixels
        self.base_pixel_arr.each do |px_arr|
            self.stitch_map << colorize_pixel(px_arr)
        end
        self.stitch_map
    end

    def colorize_pixel(px_data)
        deltae = 100000000000
        closest_px = HSLA_BLACK
        self.dominant_colors.each do |dom_px|

            hue_delta = (dom_px[0] - px_data[0]).abs

            if hue_delta < deltae

                deltae = hue_delta
                closest_px = dom_px

            elsif hue_delta == deltae

                dom_px_delta = get_full_delta(dom_px, px_data)
                current_px_delta = get_full_delta(closest_px, px_data)

                if dom_px_delta > current_px_delta
                    deltae = hue_delta
                    closest_px = dom_px
                end
            end 
        end
        hsl_arr_to_hex(closest_px)
    end

    def hex_to_hsla(str)
        color_str = Chroma::Color.new(str).to_hsl
        color_str.slice!(HSL_OPEN_CONST)
        color_str.slice!("%)")
        color_str.slice!('%')
        color_arr = color_str.split(', ')

        [color_arr[0].to_i, color_arr[1].to_i, color_arr[2].to_i, 1]
    end

    def get_full_delta(px1, px2)
        hue_delta = (px1[0] - px2[0]).abs
        sat_delta = (px1[1] - px2[1]).abs
        lit_delta = (px1[2] - px2[2]).abs

        hue_delta + sat_delta + lit_delta
    end

    def hsl_arr_to_hex(arr)
        str = "#{HSL_OPEN_CONST} #{arr[0]}, #{arr[1]}%, #{arr[2]}%)"
        Chroma::Color.new(str).to_hex
    end

    def set_num_colors(num)
        Miro.options[:color_count] = num
    end

    def view_miro_opts
        Miro.options
    end
end
