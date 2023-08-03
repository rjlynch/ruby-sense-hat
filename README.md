# SenseHat - WIP
I prefer working with Ruby, so here's a Ruby interface for the raspberry-pi sensehat.

## Features
<details>
    <summary>TODO list of supported features</summary>
    
    ### Display
    [x] clear  
    [x] set pixels  
    [x] get pixels  
    [ ] set pixel  
    [ ] get pixel  
    [ ] rotation  
    [ ] flip_h  
    [ ] flip_v  
    [ ] load_image  
    [ ] show_message  
    [x] show_letter  
    
    ### Environment
    [ ] humidity  
    [ ] temp from humidity  
    [ ] pressure  
    [ ] temp from pressure  

    ### IMU Sensor
    [ ] compass  
    [ ] gyro  
    [ ] acceleration

    ### Inputs
    [x] Joystick
</details>

## Installation
On your raspberry-pi (make sure you have ruby installed!)

`pi@raspberrypi:~/Scripts/test $ echo "gem 'sense_hat', git: 'https://github.com/rjlynch/ruby-sense-hat'" >> Gemfile`  
`pi@raspberrypi:~/Scripts/test $ bundle`  

Fire up irb and require bundler set up and the gem

```
pi@raspberrypi:~/Scripts/test $ irb
irb(main):001:0> require 'bundler/setup'
irb(main):002:0> require 'sense_hat'
```

Then have a play around!  
The below snippet will make the LED display all green.
```
irb(main):003:0> display = SenseHat::Display.new
=> #<SenseHat::Display:0x01644ea0 @device=#<SenseHat::Display::Device:0x01644e88 @device_path="/dev/fb1">>
irb(main):004:0> display.set_pixels Array.new(64) { [0, 255, 0] }
irb(main):005:0> display.clear
irb(main):006:0> exit
```
![Demo](https://github.com/rjlynch/ruby-sense-hat/blob/master/images/example.png)

## Usage

### Initialize a display object

```ruby
  display = SenseHat::Display.new
```

### Clear the display

```ruby
  display.clear
```

### Setting the display
Pass a 64 element array of RGB colour values to `set_pixels`.  
Each pixel is represented as an array of 3 integers in the range 0..255 indicating it's RGB value.  
The below example would set the whole display to red.

```ruby
  display.set_pixels([
    [255, 0, 0],
    [255, 0, 0],
    ...
    [255, 0, 0]
  ])
```

`show_letter` displays a single character on the LED display.  
It accepts optional keyword args for setting the colour and background.

```ruby
  display.show_letter 'A'
  display.show_letter 'A', colour: [0, 0, 0], background: [248, 252, 248]
```

### Reading the display
`get_pixels` will return the colour values of each LED.  
Due to the RGB565 encoding the max value returned for red or blue will be 248
and for green the max value will be 252.  
See this [stackoverflow answer](https://stackoverflow.com/questions/25467682/rgb-565-why-6-bits-for-green-color)
for more information.

```ruby
  display.get_pixels # => [[248, 0, 0], [248, 0, 0], ...  [248, 0, 0] ]
```

## Joystick
### Initialize a Joystick object
```ruby
stick = SenseHat::Stick.new
```
### read single joystick input event
reading input from joystick event.
```ruby
stick.wait_for_input
# => [:right, :press]
```
result will be in format of
```
[direction, action]
```
direction and action will have possible results as followed:
```ruby
directions: [:left, :right, :up, :down, :enter]
actions: [:press, :hold, :release]
```
to perform asynchronous reading for list of input events 
```rb
stick.start_register_inputs
=> #<Thread:0x0000007f902a8040 /{project_root}/ruby-sense-hat/lib/sense_hat/stick.rb:49 run>
```
it will spawn new thread and start recording input event actions.

to check for registered inputs,
```rb
stick.inputs
=> [[:right, :press], [:right, :release], [:left, :press], [:left, :release]]
=> 
```
clear registered inputs
```rb
stick.reset_inputs
=> []
```
remember to stop recording for every recoding of input events registration.
```rb
stick.finish_register_inputs
=> [[:right, :press], [:right, :release], [:left, :press], [:left, :release], [:up, :press], [:up, :release]]
```
You can check for thread spanwed and all available thread command can be found on official [Ruby Thread](https://ruby-doc.org/3.2.2/Thread.html) documentation.
```rb
stick.thread
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rjlynch/sense_hat.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
