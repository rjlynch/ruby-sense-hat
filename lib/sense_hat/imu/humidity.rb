module SenseHat
  class Imu
    class Humidity
      INIT_FAILURE_MESSAGE = 'Humidity sensor Init Failed!'.freeze

      def initialize(humidity_py)
        @humidity_py = humidity_py
        @init_status = humidity_py.humidityInit()
        raise InitializationFailure.new(INIT_FAILURE_MESSAGE) unless @init_status
      end

      def name
        @name ||= @humidity_py.humidityName()
      end

      class InitializationFailure < StandardError; end
    end
  end
end