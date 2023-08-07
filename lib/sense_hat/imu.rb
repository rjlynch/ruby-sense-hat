require 'forwardable'
require 'sense_hat/imu/device'

module SenseHat
  class Imu
    extend Forwardable

    ANGLE_FORMATS = { r: :roll, p: :pitch, y: :yaw }.freeze
    DEFAULT_FORMATS = { x: :x, y: :y, z: :z }

    def_delegators :@device, :imu

    def initialize
      @device = Device.new
    end

    def get_accelerometer
      return unless imu_data_present?(:accelValid)
      
      ANGLE_FORMATS
        .keys
        .zip(convert_raw_data imu.data[:accel])
        .to_h
    end

    def get_gyro
      return unless imu_data_present?(:gyroValid)
      
      ANGLE_FORMATS
        .keys
        .zip(convert_raw_data imu.data[:gyro])
        .to_h
    end

    def get_compass
      # Gets the direction of North from the orientation in degrees
      return unless imu_data_present?(:fusionPoseValid)

      # Get data from fusionPose for z value.
      # Result is -180 to +180
      degree = radian_to_degree.call(imu.data[:fusionPose].to_a[2])
      # Ressult is 0 to 360
      degree < 0 ? degree + 360 : degree
    end

    def get_compass_raw
      # Magnetometer x y z raw data in uT (micro teslas)
      return unless imu_data_present?(:compassValid)

      DEFAULT_FORMATS
        .keys
        .zip(imu.data[:compass].to_a)
        .to_h
    end

    def get_orientation
      return unless imu_data_present?(:fusionPoseValid)

      ANGLE_FORMATS
        .keys
        .zip(convert_raw_data imu.data[:fusionPose])
        .to_h
    end

    def continuous_reading
      while true
        puts yield
        sleep(imu.poll_interval.to_f/100)
      end
    end

    private

    def imu_data_present?(type_valid)
      imu &&
        imu.read &&
        imu.data &&
        imu.data[type_valid]
    end

    def convert_raw_data(data)
      data
        .to_a
        .map(&radian_to_degree)
    end

    def radian_to_degree
      proc { |value| value.to_f * 180 / Math::PI }
    end
  end  
end
