module SenseHat
  class Stick
    class Device
      SENSE_HAT_EVDEV_NAME = 'Raspberry Pi Sense HAT Joystick'.freeze
      SENSE_HAT_EVDEV_PATH = '/sys/class/input/event*'.freeze
      DEV_PATH = '/dev/input'.freeze
      DEFAUT_TIMEOUT = 10

      attr_reader :input_events

      def initialize
        @device_path = FindDevicePath.(
          SENSE_HAT_EVDEV_PATH,
          SENSE_HAT_EVDEV_NAME,
          DEV_PATH
        )
      end

      def read(timeout: DEFAUT_TIMEOUT)
        file = File.open(@device_path, 'rb')
        file.timeout = timeout
        @input_events = file.read(24)
        file.close
        @input_events
      rescue IO::TimeoutError
        nil
      end
    end
  end  
end
