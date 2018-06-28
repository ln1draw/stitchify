Gem::Specification.new do |s|
  s.name = 'stitchify'
  s.version = '0.2.2'
  s.date = '2018-06-23'
  s.summary = 'converts an image into a cross stitching pattern'
  s.description = 'ultimate goal is to input an HTML document and output an SVG cross stitching pattern'
  s.authors = ['Ellen Wondra']
  s.email = 'ellenfromillinois@gmail.com'
  s.files = ['lib/stitchify.rb']
  s.homepage = 'http://rubygems.org/gems/stitchify'
  s.license = 'MIT'

  s.add_dependency "rasem", '0.7.1'
  s.add_dependency "miro", '0.4.0'
  s.add_dependency "color", '1.8'
  s.add_dependency "chroma"
  s.add_dependency "RMagick"

  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
end