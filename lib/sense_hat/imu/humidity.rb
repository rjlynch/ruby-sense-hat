module SenseHat
  class Imu
    class Humidity
      INIT_FAILURE_MESSAGE = 'Humidity sensor Init Failed!'.freeze
      HUMIDITY_FORMAT = %i[humidityValid humidity humidityTemperatureValid humidityTemperature].freeze

      attr_reader :data

      def initialize(humidity_py)
        @humidity_py = humidity_py
        @init_status = humidity_py.humidityInit()
        raise InitializationFailure.new(INIT_FAILURE_MESSAGE) unless @init_status
      end

      def name
        @name ||= @humidity_py.humidityName()
      end

      def read
        @data = format_data HUMIDITY_FORMAT.zip(@humidity_py.humidityRead().to_a).to_h
      end

      private

      def format_data(result)
        result.tap do |hash|
          hash[:humidityValid] = to_boolean hash[:humidityValid]
          hash[:humidityTemperatureValid] = to_boolean hash[:humidityTemperatureValid]
        end
      end

      def to_boolean(value)
        !value.zero?
      end

      class InitializationFailure < StandardError; end
    end
  end
end