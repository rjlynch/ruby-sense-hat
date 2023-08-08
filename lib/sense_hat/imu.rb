require 'forwardable'
require 'sense_hat/imu/device'

module SenseHat
  class Imu
    extend Forwardable

    ANGLE_FORMAT_UNITS = { r: :degree, p: :degree, y: :degree }.freeze
    DEFAULT_FORMAT_UNITS = { x: :degree, y: :degree, z: :degree }.freeze
    PRESSURE_FORMAT_UNITS = { pressure: :mbar }.freeze
    TEMPERATURE_FORMAT_UNITS = { temperature: :celsius }.freeze
    HUMIDITY_FORMAT_UNITS = { humidity: :percentage }

    def_delegators :@device, :imu, :pressure, :humidity

    def initialize
      @device = Device.new
    end

    def get_accelerometer
      return unless imu_data_present?(:accelValid)
      
      ANGLE_FORMAT_UNITS
        .keys
        .zip(convert_radian_data imu.data[:accel])
        .to_h
        .merge({ units: ANGLE_FORMAT_UNITS }) 
    end

    def get_gyro
      return unless imu_data_present?(:gyroValid)
      
      ANGLE_FORMAT_UNITS
        .keys
        .zip(convert_radian_data imu.data[:gyro])
        .to_h
        .merge({ units: ANGLE_FORMAT_UNITS }) 
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

      DEFAULT_FORMAT_UNITS
        .keys
        .zip(imu.data[:compass].to_a)
        .to_h
        .merge({ units: DEFAULT_FORMAT_UNITS })
    end

    def get_orientation
      return unless imu_data_present?(:fusionPoseValid)

      ANGLE_FORMAT_UNITS
        .keys
        .zip(convert_radian_data imu.data[:fusionPose])
        .to_h
        .merge({ units: ANGLE_FORMAT_UNITS })
    end

    # Returns the pressure in Millibars
    def get_pressure
      return unless pressure_data_present? :pressureValid

      PRESSURE_FORMAT_UNITS
        .keys
        .zip([pressure.data[:pressure]])
        .to_h
        .merge({ units: PRESSURE_FORMAT_UNITS })
    end

    # Returns the temperature in Celsius from the pressure sensor
    def get_temperature_from_pressure
      return unless pressure_data_present? :pressureTemperatureValid

      TEMPERATURE_FORMAT_UNITS
        .keys
        .zip([pressure.data[:pressureTemperature]])
        .to_h
        .merge({ units: TEMPERATURE_FORMAT_UNITS })
    end

    # Returns the percentage of relative humidity
    def get_humidity
      return unless humidity_data_present? :humidityValid

      HUMIDITY_FORMAT_UNITS
        .keys
        .zip([humidity.data[:humidity]])
        .to_h
        .merge({ units: HUMIDITY_FORMAT_UNITS })
    end

    # Returns the temperature in Celsius from the humidity sensor
    def get_temperature_from_humidity
      return unless humidity_data_present? :humidityTemperatureValid

      TEMPERATURE_FORMAT_UNITS
        .keys
        .zip([humidity.data[:humidityTemperature]])
        .to_h
        .merge({ units: TEMPERATURE_FORMAT_UNITS })
    end

    alias get_temperature get_temperature_from_humidity

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

    def pressure_data_present?(type_valid)
      pressure &&
        pressure.read &&
        pressure.data[type_valid]
    end

    def humidity_data_present?(type_valid)
      humidity &&
        humidity.read &&
        humidity.data[type_valid]
    end

    def convert_radian_data(data)
      data
        .to_a
        .map(&radian_to_degree)
    end

    def radian_to_degree
      proc { |value| value.to_f * 180 / Math::PI }
    end
  end  
end
