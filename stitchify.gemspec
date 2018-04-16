Gem::Specification.new do |s|
  s.name = 'stitchify'
  s.version = '0.0.9'
  s.date = '2018-03-05'
  s.summary = 'converts an HTML document into a cross stitching pattern'
  s.description = 'input an HTML document and output an SVG cross stitching pattern'
  s.authors = ['Ellen Wondra']
  s.email = 'ellenfromillinois@gmail.com'
  s.files = ['lib/stitchify.rb']
  s.homepage = 'http://rubygems.org/gems/stitchify'
  s.license = 'MIT'

  s.add_dependency "nokogiri", '1.8.2'
  s.add_dependency "rasem", '0.7.1'
  s.add_dependency "asciiart", '0.0.9'

  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
end