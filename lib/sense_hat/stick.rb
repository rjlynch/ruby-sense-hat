require "sense_hat/stick/find_device_path"
require "sense_hat/stick/device"

module SenseHat
  class Stick
    # device
    EV_KEY = 0x01

    # actions
    STATE_RELEASE = 0
    STATE_PRESS = 1
    STATE_HOLD = 2

    # directions
    KEY_UP = 103
    KEY_LEFT = 105
    KEY_RIGHT = 106
    KEY_DOWN = 108
    KEY_ENTER = 28

    DIRECTION_MAPPING = {
      up: KEY_UP,
      left: KEY_LEFT,
      right: KEY_RIGHT,
      down: KEY_DOWN,
      enter: KEY_ENTER
    }.freeze

    ACTION_MAPPING = {
      release: STATE_RELEASE,
      press: STATE_PRESS,
      hold: STATE_HOLD
    }

    attr_accessor :register_inputs_completed
    attr_reader :thread, :inputs

    def initialize
      @device = Device.new
      @inputs = []
    end

    def wait_for_input(...)
      decode @device.read(...)
    end

    def start_register_inputs
      @inputs.clear
      @thread ||= Thread.new do
        while !register_inputs_completed
          @inputs << wait_for_input(timeout: nil)
        end
      end
    end

    def finish_register_inputs
      register_inputs_completed = true
      return if thread.nil?

      thread.exit if thread.status == 'sleep'
      @thread = nil
      inputs
    end

    def reset_inputs
      @inputs.clear
    end

    private

    # example input string for down button
    # "N\xDF\xC4d\x00\x00\x00\x00\x97Q\f\x00\x00\x00\x00\x00\x01\x00l\x00\x01\x00\x00\x00"
    def decode(input_string)
      map_input_event input_string.unpack('lx4lx4cxcxcx3')  
    end
    
    # example decoded input key:
    # [1690622778, 272630, 1, 108, 1]
    def map_input_event(decoded_string)
      _, _, evdev, direction, action = decoded_string
      return unless is_joystick_input?(evdev)

      [
        map_direction(direction),
        map_action(action)
      ]
    end

    def is_joystick_input?(value)
      value == EV_KEY
    end

    def map_direction(value)
      DIRECTION_MAPPING.invert[value]
    end

    def map_action(value)
      ACTION_MAPPING.invert[value]
    end
  end  
end
