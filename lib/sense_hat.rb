require "sense_hat/version"
require "sense_hat/display/find_device_path"
require "sense_hat/display/device"
require "sense_hat/display/pixel"
require "sense_hat/display/letter"
require "sense_hat/display"
require "sense_hat/stick"
require "sense_hat/imu"

module SenseHat
  class Error < StandardError; end
  class ValueError < Error; end
  class DeviceNotFound < Error; end
  class LetterNotSupported < Error; end

  # Your code goes here...
end
