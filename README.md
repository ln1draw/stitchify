# Stitchify

## Getting Started

`gem install stitchify`

`s = Stitchifier.new(URL, num_of_px, px_size, num_of_colors)`

this will create stitchify.svg if it does not already exist and populate it with svg data. To see the image, open this file.

# About this gem

This is my first gem, and my first bit of structural design!

I had never heard of a service when I wrote this code. It could probably use a few refactors after I finish my job hunt. In the meantime, I am incredibly proud of my years-old work!

This project inspired my Strange Loop talk, [Complexities of Color in Computing.](https://www.youtube.com/watch?v=VCvOwoeOgv8&feature=youtu.be)

# Getting Started

Your Stitchifier object has four initial variables, each of which has a starting value; they are, in order, image pate, width (aka number of squares), pixel size, and number of colors.

You can initialize your Stitchifier object with s = Stitchifier.new("http://www.ellenwondra.com/gothprincess.jpg", 75, 10, 15) and the Stitchifier will build an svg for you that you can open in your root directory.

You can also play with the color set and make other modifications. At this particular point in time, that requires cracking the Stitchifier object open to access internal objects, instead of requesting access to services. So much to refactor, so little time!

If you would like a working example of utilizing the DrawRasem object to build color sets, please see my code for [my personal website](https://github.com/ln1draw/new-personal-site/blob/master/app/controllers/stitchify_controller.rb) right here--live problems notwithstanding (devops is my kryptonite okay), Stitchifier works beautifully on local builds and is a lot of fun to play with!