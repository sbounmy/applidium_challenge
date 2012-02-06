require "rubygems"
require "bundler/setup"
Bundler.require
image = MiniMagick::Image.open("apple.jpg")
image.resize "64x64"
image.write  "apple-retina.jpg"