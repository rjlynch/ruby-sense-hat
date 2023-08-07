require 'pycall/import'
require 'sense_hat/imu/humidity'
require 'sense_hat/imu/imu'
require 'sense_hat/imu/pressure'

module SenseHat
  class Imu
    class Device
      include PyCall::Import

      SETTINGS_FILE_NAME = 'RTIMULib'.freeze
  
      # following methods are available through pyimport
      # attr_reader :os, :rtimu
      attr_reader :setting_file_path, :imu, :pressure, :humidity

      def initialize
        # import RTIMU and os from python library.
        @rtimu = send(pyimport :RTIMU, as: :rtimu)
        @os = send(pyimport :os)
        @setting_file_path = find_or_create_settings_file
        @imu = Imu.new(@rtimu.RTIMU.call(@setting_py))
        @pressure = Pressure.new(@rtimu.RTPressure.call(@setting_py))
        @humidity = Humidity.new(@rtimu.RTHumidity.call(@setting_py))
      end

      private

      def find_or_create_settings_file
        puts 'Using settings file ' + SETTINGS_FILE_NAME + '.ini'
        puts "Settings file does not exist, will be created" if !settings_file_exist?

        @setting_py = @rtimu.Settings.call(SETTINGS_FILE_NAME)
        @setting_file_path = os.path.abspath(SETTINGS_FILE_NAME + '.ini')
      end

      def settings_file_exist?
        @os.path.exists(SETTINGS_FILE_NAME + '.ini')
      end
    end
  end  
end
