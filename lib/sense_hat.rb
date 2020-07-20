require "sense_hat/version"
require "sense_hat/display/find_device_path"
require "sense_hat/display/device"
require "sense_hat/display/pixel"
require "sense_hat/display"

module SenseHat
  class Error < StandardError; end
  class ValueError < Error; end
  class DeviceNotFound < Error; end

  # Your code goes here...
end
