class Stitchify
    require 'nokogiri'
    require 'open-uri'

    attr_accessor :title, :links, :left

	def self.google
        self.stitch("http://www.google.com")
	end

    def self.stitch(url)
        stitcher = Stitchify.new()

        doc = stitcher.Nokogiri::HTML(open(url))
        stitcher.title = doc.title
        stitcher.links = doc.css('a')

        stitcher
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
