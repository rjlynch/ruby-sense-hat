module SenseHat
  class Display
    class Pixel
      ALLOWED_INDEX_RANGE = (0..63).freeze
      ALLOWED_RGB_RANGE = (0..255).freeze

      def self.new_from_rgb565(position:, rgb565:)
        Pixel.new(
          position: position,
          red:   (((rgb565 & 0xf800) >> 11) << 3),
          green: (((rgb565 & 0x07e0) >>  5) << 2),
          blue:  (((rgb565 & 0x001f))       << 3)
        )
      end

      attr_reader :position, :red, :green, :blue

      def initialize(position:, red:, green:, blue:)
        @position = Integer position
        @red = Integer red
        @green = Integer green
        @blue = Integer blue
      end

      def inspect
        "<#pixel index=#{position} red=#{red} green=#{green} blue=#{blue}>"
      end

      def validate!
        unless ALLOWED_INDEX_RANGE.include? position
          fail ValueError, "position out of bounds #{self.inspect}"
        end

        [red, green, blue].each do |colour|
          unless ALLOWED_RGB_RANGE.include? colour
            fail ValueError, "rgb out off bounds #{self.inspect}"
          end
        end
      end

      def rgb565
        [((@red >> 3) << 11) + ((@green >> 2) << 5) + ((@blue >> 3))].pack 'S'
      end

      def to_a
        [@red, @green, @blue]
      end
    end
  end
end
