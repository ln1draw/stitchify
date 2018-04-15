class Stitchify
    require 'nokogiri'
    require 'open-uri'
    require 'pry'
    require 'rasem'
    require 'asciiart'

    def arr_builder(img)
        AsciiArt.new(img).to_ascii_art.split("\n")
    end

    def char_builder(char)
        output = []
        case char
        when '.'
            output << pos_slope_one(15, 35, 10)
            output << neg_slope_one(15, 25, 10)
        when '~'
            output << pos_slope_one(5, 25, 10)
            output << neg_slope_one(15, 15, 10)
            output << pos_slope_one(25, 25, 10)
        when ':'
            output << pos_slope_one(15, 35, 10)
            output << neg_slope_one(15, 25, 10)
            output << pos_slope_one(15, 15, 10)
            output << neg_slope_one(15, 5, 10)
        when '+'
            output << vertical_line(25, 5, 30)
            output << horizontal_line(5, 15, 30)
        when '='
            output << horizontal_line(5, 15, 30)
            output << horizontal_line(5, 25, 30)
        when 'o'
            output << pos_slope_one(5, 15, 10)
            output << horizontal_line(15, 5, 10)
            output << neg_slope_one(25, 5, 10)
            output << vertical_line(35, 15, 10)
            output << pos_slope_one(25, 35, 10)
            output << horizontal_line(15, 35, 10)
            output << neg_slope_one(5, 25, 10)
            output << vertical_line(5, 15, 10)
        when '*'
            output << pos_slope_one(5, 35, 30)
            output << neg_slope_one(5, 5, 30)
            output << vertical_line(25, 5, 30)
        when 'x'
            output << pos_slope_one(5, 35, 30)
            output << neg_slope_one(5, 5, 30)
        when '^'
            output << pos_slope_one(15, 15, 10)
            output << neg_slope_one(25, 5, 10)
        when '%'
            output << pos_slope_one(5, 15, 10)
            output << neg_slope_one(5, 5, 10)
            output << pos_slope_one(5, 35, 30)
            output << pos_slope_one(25, 35, 10)
            output << neg_slope_one(25, 25, 10)
        when '#'
            output << vertical_line(15, 5, 30)
            output << vertical_line(25, 5, 30)
            output << horizontal_line(5, 15, 30)
            output << horizontal_line(5, 25, 30)
        when '@'
            output << pos_slope_one(25, 25, 10)
            output << neg_slope_one(25, 15, 10)
            output << vertical_line(35, 5, 20)
            output << horizontal_line(15, 5, 20)
            output << pos_slope_two(5, 25, 10)
            output << neg_slope_one(5, 25, 10)
            output << horizontal_line(15, 35, 20)
        when '$'
            output << pos_slope_one(15, 15, 10)
            output << neg_slope_one(25, 5, 10)
            output << neg_slope_half(15, 15, 10)
            output << pos_slope_one(25, 35, 10)
            output << neg_slope_one(15, 25, 10)
            output << vertical_line(25, 5, 30)
        when 'M'
            output << vertical_line(15, 5, 30)
            output << neg_slope_two(15, 5, 10)
            output << pos_slope_two(25, 25, 10)
            output << vertical_line(35, 5, 30)
        when 'W'
            output << vertical_line(15, 5, 30)
            output << pos_slope_two(15, 35, 10)
            output << neg_slope_two(25, 15, 10)
            output << vertical_line(35, 5, 30)
        when '|'
            output << vertical_line(25, 5, 30)
        when '_'
            output << horizontal_line(5, 35, 30)
        end
        output
    end

    def pos_slope_one(startX, startY, length)
        [startX, startY, startX + length, startY - length]
    end

    def neg_slope_one(startX, startY, length)
        [startX, startY, startX + length, startY + length]
    end

    def vertical_line(startX, startY, length)
        [startX, startY, startX, startY + length]
    end

    def horizontal_line(startX, startY, length)
        [startX, startY, startX + length, startY]
    end

    def pos_slope_two(startX, startY, width)
        [startX, startY, startX + width, startY - (2 * width)]
    end

    def neg_slope_half(startX, startY, height)
        [startX, startY, startX + (2 * height), startY + height]
    end

    def neg_slope_two(startX, startY, width)
        [startX, startY, startX + width, startY + (2 * width)]
    end
end

 #    attr_accessor :title, :links, :left, :px, :links_array, :left_pos, :width, :height

	# def self.google
 #        self.stitch("http://www.google.com")
	# end

 #    def self.stitch(content)
 #        stitcher = Stitchify.new()

 #        doc = stitcher.get_doc(content)
 #        stitcher.title = doc.title
 #        stitcher.links = doc.css('a')
 #        stitcher.px = 40
 #        stitcher.links_array = []
 #        stitcher.left_pos = stitcher.px
 #        stitcher.width = stitcher.px * 10
 #        stitcher.height = stitcher.px * 10

 #        stitcher.build_links_array

 #        stitcher
 #    end

 #    def get_doc(content)
 #        ret = nil
 #        if content.strip[0] == '<'
 #            ret = Nokogiri::HTML(content, nil, 'UTF-8')
 #        else
 #            ret = Nokogiri::HTML(open(content), nil, 'UTF-8')
 #        end
 #        ret
 #    end

 #    def build_links_array
 #        self.left_pos

 #        px = self.px
 #        left_pos = self.px
 #        bottom_pos = self.px * 3

 #        arr = self.links.map{ | x | x.text.strip }
 #        arr.each do |word|
 #            unless word.length == 0
 #                word.split('').each do | letter |
 #                    puts letter
 #                    add_letter(letter, left_pos, bottom_pos)

 #                    right_one_px
 #                end

 #                right_one_px
 #                right_one_px
 #            end
 #        end

 #        self.links_array
 #    end

 #    def build_svg
 #        links_array = self.links_array
 #        Rasem::SVGImage.new(width: self.width, height: self.height) do
 #            for line_data in links_array
 #                line line_data[0], line_data[1], line_data[2], line_data[3]
 #            end
 #        end
 #    end

 #    def add_letter(letter, left_pos, bottom_pos)
 #        left_pos = self.left_pos
 #        case letter
 #        when ' '
 #            right_one_px
 #        when 'A'
 #            self.links_array << [ left_pos,      bottom_pos,          left_pos,      bottom_pos - 2 * px ]
 #            self.links_array << [ left_pos,      bottom_pos - px,     left_pos + px, bottom_pos - px     ]
 #            self.links_array << [ left_pos,      bottom_pos - 2 * px, left_pos + px, bottom_pos - 2 * px ]
 #            self.links_array << [ left_pos + px, bottom_pos,          left_pos + px, bottom_pos - 2 * px ]
 #        end
 #    end

 #    def right_one_px
 #        self.left_pos = self.left_pos + self.px
 #    end

 #    def make_img
 #        Rasem::SVGImage.new(width: 400, height: 400) do

 #        end
 #    end

 #    def write_file
 #        File.open("stitchify.svg", "w") do |f|
 #            self.make_img.write(f)
 #        end
 #    end



=begin

 




15, 25, 25, 35


takes position and letter


    img = Rasem::SVGImage.new(:width=>100, :height=>100) do
2.4.1 :003 >       circle 20, 20, 5
2.4.1 :004?>     circle 50, 50, 5
2.4.1 :005?>     line 20, 20, 50, 50
2.4.1 :006?>   end

2.4.1 :007 > File.open("stitchify.svg", "w") do |f|
2.4.1 :008 >     img.write(f)
2.4.1 :009?>   end

def stitch(img)
    File.open("stitchify.svg", "w") do |f|
        img.write(f)
    end
end
stitcher.links[5].text
    
=end
