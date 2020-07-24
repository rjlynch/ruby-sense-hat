module SenseHat
  class Display
    class Pixel
      ALLOWED_INDEX_RANGE = (0..63).freeze
      ALLOWED_RGB_RANGE = (0..255).freeze

      def self.new_from_rgb565(rgb565)
        Pixel.new(
          red:   (((rgb565 & 0xf800) >> 11) << 3),
          green: (((rgb565 & 0x07e0) >>  5) << 2),
          blue:  (((rgb565 & 0x001f))       << 3)
        )
      end

      def self.new_from_array(array)
        Pixel.new red: array[0], green: array[1], blue: array[2]
      end

      attr_reader :red, :green, :blue

      def initialize(red:, green:, blue:)
        @red = Integer red
        @green = Integer green
        @blue = Integer blue
      end

      def inspect
        "<#pixel red=#{red} green=#{green} blue=#{blue}>"
      end

      def validate!
        [red, green, blue].each do |colour|
          unless ALLOWED_RGB_RANGE.include? colour
            raise ValueError, "rgb out off bounds #{self.inspect}"
          end
        end
      end

      def rgb565
        [((@red >> 3) << 11) + ((@green >> 2) << 5) + ((@blue >> 3))]
      end

      def to_a
        [@red, @green, @blue]
      end
    end
  end
end
