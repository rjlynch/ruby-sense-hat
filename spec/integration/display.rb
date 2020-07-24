require "bundler/setup"
require "sense_hat"

display = SenseHat::Display.new

TESTS = {
  'All red'         => Array.new(64) { [248, 0, 0] },
  'All green'       => Array.new(64) { [0, 252, 0] },
  'All blue'        => Array.new(64) { [0, 0, 248] },
  'Diagonal cross'  => Array.new(64) { [0, 0, 0] }.each_with_index.map { |a, i| i % 9 == 0 || i % 7 == 0 ? [248, 252, 0] : a }
}

TESTS.each do |name, test|
  display.clear
  puts '-' * 80
  puts name
  display.set_pixels test
  returned_pixels = display.get_pixels
  unless returned_pixels == test
    fail "unexpected pixels #{returned_pixels.inspect} expected #{test.inspect}"
  end
  sleep 1
end

(('A'..'Z').to_a + (0..9).to_a).each do |char|
  puts char
  display.show_letter char
  sleep 0.2
end

display.clear
