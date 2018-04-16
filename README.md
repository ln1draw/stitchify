# Stitchify

make some great ASCII art cross stitch patterns!

## Getting Started

`gem install stitchify`

## Usage

`Stitchifier.new`
`Stitchifier.stitch('path_to_img', 'svg_output_file')

Open the SVG and voila!

## Options

You can change the pixel size optionally when you instantiate the Stitchifier

`Stitchifier.new(5)`

You can also change the ASCII width (the number of characters in the ASCII art)

`Stitchifier.new(5, 50)`

## Run tests

`rspec` will run the tests

## Disclaimer

Hi! This is my first real gem. I am aware that the documentation is lacking. I'm really tired, so I'm going to bed for now, but I'll get back to it!