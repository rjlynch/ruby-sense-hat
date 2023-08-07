module SenseHat
  class Imu
    class Pressure
      INIT_FAILURE_MESSAGE = 'Pressure sensor Init Failed!'.freeze

      def initialize(pressure_py)
        @pressure_py = pressure_py
        @init_status = pressure_py.pressureInit()
        raise InitializationFailure.new(INIT_FAILURE_MESSAGE) unless @init_status
      end

      def name
        @name ||= @pressure_py.pressureName()
      end

      class InitializationFailure < StandardError; end
    end
  end
end
