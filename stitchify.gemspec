Gem::Specification.new do |s|
  s.name = 'stitchify'
  s.version = '0.4.0'
  s.date = '2020-02-27'
  s.summary = 'converts an image into a cross stitching pattern'
  s.description = 'takes a .jpg image and converts it to an SVG cross stitching pattern. You can change the colors, the width, and the number of colors used.'
  s.authors = ['Ellen Wondra']
  s.email = 'ellenfromillinois@gmail.com'
  s.files = ['lib/stitchify.rb', 'lib/stitchify/pixelfy.rb', 'lib/stitchify/draw_rasem.rb']
  s.homepage = 'https://github.com/ln1draw/stitchify'
  s.license = 'MIT'

  s.add_dependency "rasem", '0.7.1'
  s.add_dependency "miro", '0.4.0'
  s.add_dependency "color", '1.8'
  s.add_dependency "chroma", '0.2.0'
  s.add_dependency "rmagick", '~> 2.16'

  s.add_development_dependency "rake", '12.3.1'
  s.add_development_dependency "pry", '0.11.3'
end