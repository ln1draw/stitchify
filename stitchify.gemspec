Gem::Specification.new do |s|
  s.name = 'stitchify'
  s.version = '0.2.5'
  s.date = '2018-06-23'
  s.summary = 'converts an image into a cross stitching pattern'
  s.description = 'ultimate goal is to input an HTML document and output an SVG cross stitching pattern'
  s.authors = ['Ellen Wondra']
  s.email = 'ellenfromillinois@gmail.com'
  s.files = ['lib/stitchify.rb', 'lib/stitchify/pixelfy.rb', 'lib/stitchify/draw_rasem.rb']
  s.homepage = 'https://github.com/ln1draw/stitchify'
  s.license = 'MIT'

  s.add_dependency "rasem", '0.7.1'
  s.add_dependency "miro", '0.4.0'
  s.add_dependency "color", '1.8'
  s.add_dependency "chroma"
  s.add_dependency "rmagick"

  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
end