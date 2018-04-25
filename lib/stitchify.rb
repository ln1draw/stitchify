class Stitchifier
    require 'nokogiri'
    require 'open-uri'
    require 'pry'
    require 'rasem'
    require 'asciiart'
    require 'hex256'

    OPEN_BRACKET = "\e[38;5;"
    CLOSE_BRACKET = "\e[0m"

    attr_accessor :px, :pos_x, :pos_y, :width, :height, :ascii_width

    def initialize(px = 10, ascii_width = nil)
        self.px = px
        self.pos_x = 0
        self.pos_y = 0
        self.width = 4 * px
        self.height = 4 * px
        self.ascii_width = ascii_width
    end

    def stitch(img, file = 'stitchify.svg')
        ascii = img_processor(img)
        arrs = paragraph_builder(ascii)
        rasem = arrs_to_rasem(arrs, grid)
        write(rasem, file)
        clear_vars
    end

    # ".~:+=o*x^%#@$MW\n .~:+=o*x^%#@$M\nW.~:+=o*x^%  #@$MW"

    def stitch_string(str, file = 'stitchify.svg')
        arrs = paragraph_builder(str)
        rasem = arrs_to_rasem(arrs, grid)
        write(rasem, file)
        clear_vars
    end

    def clear_vars
        self.pos_x = 0
        self.pos_y = 0
        self.width = 0
        self.height = 0
    end

    def ascii_conditions
        ret = {}
        ret[:color] = true
        ret[:width] = self.ascii_width unless self.ascii_width.nil?
        ret
    end

    def img_processor(img)
        AsciiArt.new(img).to_ascii_art(ascii_conditions)
    end

    def arrs_to_rasem(arrs, grid)
        Rasem::SVGImage.new(width: self.width, height: self.height) do
            for line_data in arrs
                line line_data[0], line_data[1], line_data[2], line_data[3], :stroke_width=>2, :fill=>line_data[4], :stroke=>line_data[4]
                # line line_data[0], line_data[1], line_data[2], line_data[3], :stroke_width=>2, :fill=>"red", :stroke=>"red"
            end
            for line_data in grid
                line line_data[0], line_data[1], line_data[2], line_data[3], :stroke_width=>line_data[5]
            end
        end
    end

    def write(rasem, file)
        File.open(file, "w") do |f|
            rasem.write(f)
        end
    end

    def grid
        n = 10
        output = []
        (width / n).times do |i|
            x = 1
            x = 2 if (i % 10 == 0)
            output << [i * n, 0, i * n, height, 'black', x]
        end
        (height / n).times do |i|
            x = 1
            x = 2 if i % 10 == 0
            output << [0, i * n, width, i * n, 'black', x]
        end
        output
    end

    def paragraph_builder(str)
        self.height = 0
        arr = str.split("\n")
        output = []
        arr.each do |line|
            output = output + line_builder(line)
            self.pos_y = self.pos_y + (4 * px)
            self.pos_x = 0
            self.height = self.height + (4 * px)
        end
        output
    end

    def line_builder(line)
        self.width = 0
        line_output = []

        l = line.split(OPEN_BRACKET)

        l.each do |segment|

            char_data = segment.split("m")

            # if the midpoint doesn't exist
            if char_data.length == 1 
                char_data[0].chars.each do |char|
                    line_output = line_output + char_builder(char, '#000000')
                    self.pos_x = self.pos_x + (3 * px)
                    self.width = self.width + (3 * px)
                end
            else
                char = char_data[1].delete(CLOSE_BRACKET)
                line_output = line_output + char_builder(char, HexConverter.ansi_to_hex(char_data[0]))
                self.pos_x = self.pos_x + (3 * px)
                self.width = self.width + (3 * px)
            end
        end

        line_output
    end

    def char_builder(char, hex_str)
        output = []
        case char
        when '.'
            output << pos_slope_one(1.5 * px, 2.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, 1.5 * px, px, hex_str)
        when '~'
            output << pos_slope_one((0 - px / 2), 2.5 * px, px, hex_str)
            output << neg_slope_one(px / 2,       1.5 * px, px, hex_str)
            output << pos_slope_one(1.5 * px,     2.5 * px, px, hex_str)
        when ':'
            output << pos_slope_one(1.5 * px, 2.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, 1.5 * px, px, hex_str)
            output << pos_slope_one(1.5 * px, 1.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, px / 2,   px, hex_str)
        when '+'
            output << vertical_line(1.5 * px, px / 2,   2 * px, hex_str)
            output << horizontal_line(px / 2, 1.5 * px, 2 * px, hex_str)
        when '='
            output << horizontal_line(px / 2, 1.5 * px, 2 * px, hex_str)
            output << horizontal_line(px / 2, 2.5 * px, 2 * px, hex_str)
        when 'o'
            output << pos_slope_one(px / 2,   1.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, px / 2,   px, hex_str)
            output << pos_slope_one(1.5 * px, 2.5 * px, px, hex_str)
            output << neg_slope_one(px / 2,   1.5 * px, px, hex_str)
        when '*'
            output << pos_slope_one(px / 2,   2.5 * px , 2 * px, hex_str)
            output << neg_slope_one(px / 2,   px / 2,    2 * px, hex_str)
            output << vertical_line(1.5 * px, px / 2,    2 * px, hex_str)
        when 'x'
            output << pos_slope_one(px / 2,   2.5 * px , 2 * px, hex_str)
            output << neg_slope_one(px / 2,   px / 2,    2 * px, hex_str)
        when '^'
            output << pos_slope_one(px / 2,   1.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, px / 2,   px, hex_str)
        when '%'
            output << pos_slope_one(px / 2,   1.5 * px, px, hex_str)
            output << neg_slope_one(px / 2,   px / 2,   px, hex_str)
            output << pos_slope_one(px / 2,   2.5 * px, 2 * px, hex_str)
            output << pos_slope_one(1.5 * px, 2.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, 1.5 * px, px, hex_str)
        when '#'
            output << pos_slope_two(px / 2,   2.5 * px, px, hex_str)
            output << pos_slope_two(1.5 * px, 2.5 * px, px, hex_str)
            output << horizontal_line(px / 2, 1.5 * px, 2 * px, hex_str)
            output << horizontal_line(px / 2, 2.5 * px, 2 * px, hex_str)
        when '@'
            output << pos_slope_one(1.5 * px,   2.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px,   1.5 * px, px, hex_str)
            output << vertical_line(2.5 * px,   px / 2,   2 * px, hex_str)
            output << horizontal_line(1.5 * px, px / 2,   px, hex_str)
            output << pos_slope_one(px / 2,     1.5 * px, px, hex_str)
            output << neg_slope_one(px / 2,     1.5 * px, px, hex_str)
            output << horizontal_line(1.5 * px, 2.5 * px, px, hex_str)
        when '$'
            output << horizontal_line(px / 2, px / 2,   2 * px, hex_str)
            output << neg_slope_one(px / 2,   px / 2,   2 * px, hex_str)
            output << horizontal_line(px / 2, 2.5 * px, 2 * px, hex_str)
            output << vertical_line(1.5 * px, px / 2,   2 * px, hex_str)
        when 'M'
            output << vertical_line(px / 2,   px / 2,   2 * px, hex_str)
            output << neg_slope_one(px / 2,   px / 2,   px, hex_str)
            output << pos_slope_one(1.5 * px, 1.5 * px, px, hex_str)
            output << vertical_line(2.5 * px, px / 2,   2 * px, hex_str)
        when 'W'
            output << vertical_line(px / 2,   px / 2,   2 * px, hex_str)
            output << pos_slope_one(px / 2,   2.5 * px, px, hex_str)
            output << neg_slope_one(1.5 * px, 1.5 * px, px, hex_str)
            output << vertical_line(2.5 * px, px / 2,   2 * px, hex_str)
        when '|'
            output << vertical_line(2.5 * px, px / 2, 2 * px, hex_str)
        when '-'
            output << horizontal_line(px / 2, 2.5 * px, 2 * px, hex_str)
        end
        output
    end

    def pos_slope_one(startX, startY, length, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x + length,
            startY + pos_y - length,
            hex_str
        ]
    end

    def neg_slope_one(startX, startY, length, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x + length,
            startY + pos_y + length,
            hex_str
        ]
    end

    def vertical_line(startX, startY, length, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x,
            startY + pos_y + length,
            hex_str
        ]
    end

    def horizontal_line(startX, startY, length, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x + length,
            startY + pos_y,
            hex_str
        ]
    end

    def pos_slope_two(startX, startY, width, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x + width,
            startY + pos_y - (2 * width),
            hex_str
        ]
    end

    def neg_slope_half(startX, startY, height, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x + (2 * height),
            startY + pos_y + height,
            hex_str
        ]
    end

    def neg_slope_two(startX, startY, width, hex_str)
        [
            startX + pos_x,
            startY + pos_y,
            startX + pos_x + width,
            startY + pos_y + (2 * width),
            hex_str
        ]
    end
end

s = Stitchifier.new
s.ascii_width = 50
s.stitch('../../../Downloads/MYFACE.jpg')