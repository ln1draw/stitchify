class Stitchify
    require 'nokogiri'
    require 'open-uri'
    require 'pry'
    require 'rasem'

    attr_accessor :title, :links, :left, :px, :links_array, :left_pos, :width, :height

	def self.google
        self.stitch("http://www.google.com")
	end

    def self.stitch(content)
        stitcher = Stitchify.new()

        doc = stitcher.get_doc(content)
        stitcher.title = doc.title
        stitcher.links = doc.css('a')
        stitcher.px = 40
        stitcher.links_array = []
        stitcher.left_pos = stitcher.px
        stitcher.width = stitcher.px * 10
        stitcher.height = stitcher.px * 10

        stitcher.build_links_array

        stitcher
    end

    def get_doc(content)
        ret = nil
        if content.strip[0] == '<'
            ret = Nokogiri::HTML(content)
        else
            ret = Nokogiri::HTML(open(content))
        end
        ret
    end

    def build_links_array
        self.left_pos

        px = self.px
        left_pos = self.px
        bottom_pos = self.px * 3

        arr = self.links.map{ | x | x.text.strip }
        arr.each do |word|
            unless word.length == 0
                word.split('').each do | letter |
                    add_letter(letter, left_pos, bottom_pos)

                    right_one_px
                end

                right_one_px
                right_one_px
            end
        end

        self.links_array
    end

    def build_svg
        links_array = self.links_array
        Rasem::SVGImage.new(width: self.width, height: self.height) do
            for line_data in links_array
                line line_data[0], line_data[1], line_data[2], line_data[3]
            end
        end
    end

    def add_letter(letter, left_pos, bottom_pos)
        left_pos = self.left_pos
        case letter
        when ' '
            right_one_px
        when 'A'
            self.links_array << [ left_pos,      bottom_pos,          left_pos,      bottom_pos - 2 * px ]
            self.links_array << [ left_pos,      bottom_pos - px,     left_pos + px, bottom_pos - px     ]
            self.links_array << [ left_pos,      bottom_pos - 2 * px, left_pos + px, bottom_pos - 2 * px ]
            self.links_array << [ left_pos + px, bottom_pos,          left_pos + px, bottom_pos - 2 * px ]
        end
    end

    def right_one_px
        self.left_pos = self.left_pos + self.px
    end

    def make_img
        Rasem::SVGImage.new(width: 400, height: 400) do

        end
    end

    def write_file
        File.open("stitchify.svg", "w") do |f|
            self.make_img.write(f)
        end
    end

    def capital_a
        line x, x, x, f
        line h, x, h, f
        line x, x, h, x
        line x, h, h, h
    end

    def lower_a
        line x, h, h, h
        line h, h, h, f
        line h, f, x, f
        line x, l, h, l
        line x, l, x, f
    end

    def capital_b
        line x, x, t, x
        line x, x, x, f
        line x, f, h, f
        line h, f, h, h
        line h, h, x, h
        line t, x, t, h
    end


end


=begin

 






takes position and letter


    img = Rasem::SVGImage.new(:width=>100, :height=>100) do
2.4.1 :003 >       circle 20, 20, 5
2.4.1 :004?>     circle 50, 50, 5
2.4.1 :005?>     line 20, 20, 50, 50
2.4.1 :006?>   end

2.4.1 :007 > File.open("stitchify.svg", "w") do |f|
2.4.1 :008 >     img.write(f)
2.4.1 :009?>   end


stitcher.links[5].text
    
=end
