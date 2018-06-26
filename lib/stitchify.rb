class Stitchifier
    require 'RMagick'
    require 'chroma'
    require 'miro'
    require 'color'
    require 'pry'
    include Magick
    include Chroma
    include Miro

    HSLA_BLACK = [0, 0, 0, 1]
    HSLA_WHITE = [0, 0, 100, 1]
    HSL_OPEN_CONST = "hsl("

    attr_accessor :width, :img_path, :img, :num_of_colors, :dominant_colors, :base_pixel_arr

    def initialize(img_path = '', width = 50, num_of_colors = 8)
        # sets variables
        set_num_colors(num_of_colors)
        self.num_of_colors = num_of_colors
        self.width = width
        self.num_of_colors = num_of_colors
        self.img_path = img_path
        self.dominant_colors = []

        unless img_path.empty?
            make_img
            set_dominant_colors
            build_pixel_array
            make_pattern
            make_grid
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
        self.base_pixel_arr.each do |hash|

        end
        # compare each pixel with the dominant colors map plus black and white
        # build new array of pixels using one of the colors indicated in comparison above (most similar to dominant colors)
    end

    def colorize_pixel(px_data)
        # binding.pry
    end

    def hex_to_hsla(str)
        color_str = Color.new(str).to_hsl
        color_str.slice!(HSL_OPEN_CONST)
        color_str.slice!("%)")
        color_str.slice!('%')
        color_arr = color_str.split(', ')

        [color_arr[0].to_i, color_arr[1].to_i, color_arr[2].to_i, 1]
    end

    def make_grid
        # builds cross stitch grid
    end

    def make_pattern
        # builds cross stitch pattern
    end

    def set_num_colors(num)
        Miro.options[:color_count] = num
    end

    def view_miro_opts
        Miro.options
    end
end
