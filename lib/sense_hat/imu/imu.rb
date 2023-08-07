module SenseHat
  class Imu
    class Imu
      INIT_FAILURE_MESSAGE = 'Imu Init Failed!'.freeze
      IMU_KEYS = %i[timestamp fusionPoseValid fusionPose fusionQPoseValid fusionQPose
                    gyroValid gyro accelValid accel compassValid compass].freeze

      attr_reader :poll_interval, :slerp_power, :gyro, :accelero, :compass, :data

      def initialize(imu_py, gyro: true, accelero: true, compass: true)
        @imu_py = imu_py
        @init_status = imu_py.IMUInit()
        raise InitializationFailure.new(INIT_FAILURE_MESSAGE) unless @init_status

        @poll_interval = imu_py.IMUGetPollInterval()
        @slerp_power = set_slerp_power(0.02)
        @gyro = enable_gyroscope(gyro)
        @accelero = enable_accelerometer(accelero)
        @compass = enable_compass(compass)
      end

      def name
        @name ||= @imu_py.IMUName()
      end

      def read
        return unless @imu_py.IMURead()

        @data = filter_data @imu_py.getIMUData()
      end

      private

      def set_slerp_power(value)
        @imu_py.setSlerpPower(value)
        value
      end

      def enable_gyroscope(signal)
        validate_boolean! signal
        @imu_py.setGyroEnable(signal)
        signal
      end

      def enable_accelerometer(signal)
        validate_boolean! signal
        @imu_py.setAccelEnable(signal)
        signal
      end

      def enable_compass(signal)
        validate_boolean! signal
        @imu_py.setCompassEnable(signal)
        signal
      end

      def validate_boolean!(value)
        raise InvalidBooleanInput unless is_boolean?(value)

        true
      end

      def is_boolean?(value)
        [true, false].include?(value)
      end

      def filter_data data
        data
          .to_h
          .transform_keys(&:to_sym)
          .select {|key, _| IMU_KEYS.include? key }
      end

      class InitializationFailure < StandardError; end
      class InvalidBooleanInput < StandardError; end
    end
  end
end