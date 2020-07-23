module SenseHat
  class Display
    class FindDevicePath
      # Frame buffer devices are listed as directories in /sys/class/graphics.
      # There's multiple fb devices, one is an emulator, one is the actual LED
      # display.
      # We need to read the content of the name file in each fb dir to find
      # which one is the real device.
      # Once we know which is the real device we can read from it at
      # /dev/<device-name>, eg /dev/fb1
      #
      # @param [String] frame_buffer_names_paths, path to search for available devices, eg '/sys/class/graphics/fb*'
      # @param [String] sense_hat_fb_name, name of the real fb device, eg 'RPi-Sense FB'
      # @param [String] dev_path, path to devices eg '/dev'
      # @return [String] path to the LED device eg '/dev/fb1'
      def self.call(frame_buffer_names_paths, sense_hat_fb_name, dev_path)
        device_name_path = \
          Dir.glob(frame_buffer_names_paths)
             .map { |dir|  File.join(dir, 'name') }
             .select { |file_name| File.exist? file_name }
             .detect { |file_name| File.read(file_name).chomp == sense_hat_fb_name }

        if device_name_path.nil?
          fail DeviceNotFound,
            "could not find any device matching #{sense_hat_fb_name} in #{frame_buffer_names_paths}"
        end

        # eg "/sys/class/graphics/fb1/name #=> fb1"
        device_name = File.dirname(device_name_path).split('/').last
        device_path = File.join(dev_path, device_name)

        unless File.exist? device_path
          fail DeviceNotFound, "could not find any device at #{device_path}"
        end

        device_path
      end
    end
  end
end
