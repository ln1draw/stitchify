class Stitchify
    require 'nokogiri'
    require 'open-uri'

    attr_accessor :title, :links

	def self.google
        stitcher = Stitchify.new()
		doc = stitcher.stitch_external('http://www.google.com')
        stitcher.title = doc.title
        stitcher.links = doc.css('a')

        stitcher
	end

    def stitch_external(url)
        Nokogiri::HTML(open(url))
    end
end


=begin
    

    
=end
