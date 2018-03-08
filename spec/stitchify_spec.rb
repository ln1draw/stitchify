require 'spec_helper'

describe "Stitchify" do
    describe 'instance method' do
        describe 'get_doc' do
            it 'returns a Nokogiri doc object when given a valid html string' do
                stitcher = Stitchify.new()
                ret = stitcher.get_doc("<html><body><h1>Hello</h1></body></html>")
                expect(ret.class).to be(Nokogiri::HTML::Document)
            end

            it 'returns a Nokogiri doc object when given a valid link' do
                stitcher = Stitchify.new()
                ret = stitcher.get_doc("http://www.google.com")
            end
        end

        describe 'build_links_array' do
            before(:all) do
                @html_str = "<html><body><a href='example.com'>A</a></body></html>"
            end

            it 'returns an array of arrays' do
                stitcher = Stitchify.stitch(@html_str)
                ret = stitcher.get_doc(@html_str)
                stitcher.build_links_array
                expect(stitcher.links_array.class).to eq(Array)
                expect(stitcher.links_array[0].class).to eq(Array)
            end

            it 'returns A' do
                stitcher = Stitchify.stitch("<html><body><a href='example.com'>A A</a></body></html>")
                ret = stitcher.get_doc(@html_str)
                stitcher.build_links_array
                expect(stitcher.links_array).to eq([[40, 120, 40, 40], [40, 80, 80, 80], [40, 40, 80, 40], [80, 120, 80, 40], [160, 120, 160, 40], [160, 80, 200, 80], [160, 40, 200, 40], [200, 120, 200, 40]])
            end
        end

        describe 'build_svg' do
            before(:each) do
                @html_str = "<html><body><a href='example.com'>A</a></body></html>"
                @stitcher = Stitchify.stitch(@html_str)
                @stitcher.build_links_array
            end

            it 'returns an svg' do
                ret = @stitcher.build_svg
                expect(ret.class).to eq(Rasem::SVGImage)
            end
        end
    end

    describe 'class method' do
        describe 'stitch' do
            it 'returns a set stitcher' do
                stitcher = Stitchify.stitch('http://www.google.com')
                expect(stitcher.title).to eq('Google')
            end

            it 'sets the links to eq a nokogiri xml nodeset of nokogiri xml elements' do
                stitcher = Stitchify.stitch('http://www.google.com')
                expect(stitcher.links.class).to eq(Nokogiri::XML::NodeSet)
                expect(stitcher.links[0].class).to eq(Nokogiri::XML::Element)
            end
        end
    end
end


    # def self.stitch(content)
    #     stitcher = Stitchify.new()

    #     doc = stitcher.get_doc(content)
    #     stitcher.title = doc.title
    #     stitcher.links = doc.css('a')

    #     stitcher.build_links

    #     stitcher
    # end