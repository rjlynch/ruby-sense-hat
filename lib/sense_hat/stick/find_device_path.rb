module SenseHat
  class Stick
    class FindDevicePath
      def self.call(sense_hat_evdev_path, sense_hat_evdev_name, dev_path)
        device_name_path = \
          Dir.glob(sense_hat_evdev_path)
             .map { |dir|  File.join(dir, 'device', 'name') }
             .select { |file_name| File.exist? file_name }
             .detect { |file_name| File.read(file_name).chomp == sense_hat_evdev_name }

        if device_name_path.nil?
          fail DeviceNotFound,
            "could not find any device matching #{sense_hat_evdev_name} in #{sense_hat_evdev_path}"
        end

        # eg "/sys/class/input/event2/device/name #=> event0"
        device_name = File.dirname(device_name_path).split('/')[-2]
        device_path = File.join(dev_path, device_name)

        unless File.exist? device_path
          fail DeviceNotFound, "could not find any device at #{device_path}"
        end

        device_path
      end
    end
  end
end
