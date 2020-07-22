# SenseHat
I prefer working with Ruby, so here's a Ruby wrapper around the raspberry-pi sensehat.

## TODO
### Display
[x] clear  
[x] set pixels  
[ ] get pixels  
[ ] set pixel  
[ ] get pixel  
[ ] rotation  
[ ] flip_h  
[ ] flip_v  
[ ] load_image  
[ ] show_message  
[ ] show_letter  

### Environment
[ ] humidity  
[ ] temp from humidity  
[ ] pressure  
[ ] temp from pressure  

### IMU Sensor
[ ] compass  
[ ] gyro  
[ ] acceleration  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sense_hat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sense_hat

## Usage

Initialize a display object

```ruby
  display = SenseHat::Display.new
```

### Clear the display

```ruby
  display.clear
```

### Setting the display
Pass a 64 element array of RGB colour values to `SenseHat::Display#set_pixels`.  
Each pixel is represented as an array of 3 integers in the range 0..255  
indicating it's RGB value.  
The below example would set the whole display to red.

```ruby
  display.set_pixels([
    [255, 0, 0],
    [255, 0, 0],
    ...
    [255, 0, 0]
  ])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sense_hat.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
