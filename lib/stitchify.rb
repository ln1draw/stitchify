require 'chroma'
require 'color'
require 'miro'
require 'pry'
require 'rasem'
require 'RMagick'

require 'stitchify/draw_rasem.rb'
require 'stitchify/pixelfy.rb'

class Stitchifier
    include Chroma
    include Magick
    include Miro

    HSLA_BLACK = [0, 0, 0, 1]
    HSLA_WHITE = [0, 0, 100, 1]
    HSL_OPEN_CONST = "hsl("
    FILLABLE_SHAPES = [
        'sm_rectangle',
        'triangle',
        'circle',
        'diamond',
        'reverse_triangle',
        'left_triangle',
        'right_triangle'
    ]

    attr_accessor :base_pixel_arr,
                  :color_set,
                  :dominant_colors,
                  :img,
                  :img_path,
                  :num_of_colors,
                  :num_of_off_colors,
                  :pos_x,
                  :pos_y,
                  :px,
                  :stitch_map,
                  :width

    def initialize(img_path = '', width = 50, px=10, num_of_colors = 8)
        # sets variables
        self.num_of_colors = num_of_colors
        set_num_colors
        self.width = width
        self.num_of_colors = num_of_colors
        self.img_path = img_path
        self.dominant_colors = []
        self.stitch_map = []
        self.px = px
        self.color_set = nil

        unless img_path.empty?
            make_img
            build_color_set
            build_pixel_array

            d = DrawRasem.new(self.stitch_map, self.width, self.px)
            d.stitch
        end
    end

    def make_img
        self.img = ImageList.new(img_path).resize_to_fit(width)
    end

    def set_dominant_colors
        color_pos = 0
        colors = black_and_white
        set_num_colors
        if self.num_of_colors > 3 && !img_path.empty?
            miro_data = Miro::DominantColors.new(self.img_path).to_hex unless self.img_path.empty?
            main_color = miro_data.slice!(0, 1)[0]
            miro_px = miro_data.map{|x| Pixelfy.from_hex(x)}
            off_colors = build_off_color_arr(main_color)
            colors = miro_px + off_colors + colors
        end
        colors.each do |px|
            if px.shape.nil?
                px.shape = FILLABLE_SHAPES[color_pos]
                color_pos = (color_pos + 1) % FILLABLE_SHAPES.length
            end
        end
        self.dominant_colors = colors.uniq
    end

    def build_color_set(req_colors = [])
        if req_colors.length == 0
            set_dominant_colors
            self.color_set = self.dominant_colors
        else
            set_dominant_colors
            colors = self.dominant_colors
            colors.slice!(0, req_colors.length)
            self.color_set = colors + req_colors.map{ |x| Pixelfy.from_hex(x) }
        end
    end

    def black_and_white
        [Pixelfy.new(0, 0, 0, 'x'), Pixelfy.new(0, 0, 100, 'circle')]
    end

    def build_pixel_array
        get_pixels
        colorize_pixels
    end

    def get_pixels
        px = []

        unless self.img.nil?
            self.img.each_pixel do | pixel, col, row |
                pixel = pixel.to_hsla
                px << Pixelfy.new(pixel[0], pixel[1], pixel[2])
            end
        end
        self.base_pixel_arr = px
    end

    def colorize_pixels
        self.base_pixel_arr.each {|px| self.stitch_map << px.colorize(self.color_set) }
    end

    def set_num_colors
        num = self.num_of_colors - 2
        case num
        when 1
            set_miro(1, 0)
        when 2
            set_miro(1, 1)
        when 3
            set_miro(2, 1)
        when 4
            set_miro(2, 2)
        when 5
            set_miro(3, 2)
        when 6
            set_miro(3, 3)
        else
            set_miro(num - 3, 3)
        end 
    end

    def set_miro(cc, off_c)
        Miro.options[:color_count] = cc
        self.num_of_off_colors = off_c
    end

    def build_off_color_arr(color)
        palette = []
        if !!color
            c = Chroma::Color.new(color)
            palette = c.palette
            case self.num_of_off_colors
            when 0
                palette = []
            when 1
                palette = palette.complement.map{|x| Pixelfy.from_hex(x.to_s)}
            when 2
                palette = palette.triad.map{|x| Pixelfy.from_hex(x.to_s)}
            when 3
                palette = palette.tetrad.map{|x| Pixelfy.from_hex(x.to_s)}
            end
        end
        palette
    end

    def view_miro_opts
        Miro.options
    end
end
