module SenseHat
  class Display
    class Device
      def self.frame_buffer_names_paths
        '/sys/class/graphics/fb*'.freeze
      end

      def self.sense_hat_fb_name
        'RPi-Sense FB'.freeze
      end

      def self.dev_path
        '/dev'
      end

      def initialize
        @device_path = FindDevicePath.(
          Device.frame_buffer_names_paths,
          Device.sense_hat_fb_name,
          Device.dev_path
        )
      end

      def write(content)
        File.open(@device_path, 'wb') do |f|
          f.write content
        end
      end

      def read
        File.binread @device_path
      end
    end
  end
end
