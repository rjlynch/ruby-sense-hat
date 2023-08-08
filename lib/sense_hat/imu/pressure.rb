module SenseHat
  class Imu
    class Pressure
      INIT_FAILURE_MESSAGE = 'Pressure sensor Init Failed!'.freeze
      PRESSURE_FORMAT = %i[pressureValid pressure pressureTemperatureValid pressureTemperature].freeze

      attr_reader :data

      def initialize(pressure_py)
        @pressure_py = pressure_py
        @init_status = pressure_py.pressureInit()
        raise InitializationFailure.new(INIT_FAILURE_MESSAGE) unless @init_status
      end

      def name
        @name ||= @pressure_py.pressureName()
      end

      def read
        @data = format_data PRESSURE_FORMAT.zip(@pressure_py.pressureRead().to_a).to_h
      end

      private

      def format_data(result)
        result.tap do |hash|
          hash[:pressureValid] = to_boolean hash[:pressureValid]
          hash[:pressureTemperatureValid] = to_boolean hash[:pressureTemperatureValid]
        end
      end

      def to_boolean(value)
        !value.zero?
      end

      class InitializationFailure < StandardError; end
    end
  end
end
