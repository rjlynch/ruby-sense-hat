require "bundler/setup"
require "sense_hat"

display = SenseHat::Display.new

TESTS = {
  'All red'         => Array.new(64) { [255, 0, 0] },
  'All green'       => Array.new(64) { [0, 255, 0] },
  'All blue'        => Array.new(64) { [0, 0, 255] },
  'Diagonal cross'  => Array.new(64) { [0, 0, 0] }.each_with_index.map { |a, i| i % 9 == 0 || i % 7 == 0 ? [255, 255, 0] : a }
}

TESTS.each do |name, test|
  display.clear
  puts '-' * 80
  puts name
  display.set_pixels test
  p display.get_pixels
  sleep 1
end

display.clear
