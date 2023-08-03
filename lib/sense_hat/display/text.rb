module SenseHat
  class Display
    class Text
      EMPTY_PIXEL = [0, 0, 0].freeze
      ROW_SIZE = 8

      attr_reader :encoded_text

      def initialize(text, on:, off:)
        @text = text
        @on = on
        @off = off
      end

      def display(position: 0)
        encode_letter_from_text
          .each { |pixel_row| shift_and_pad_pixels(pixel_row, position)}
          .map { |pixel_row| pixel_row.take ROW_SIZE }
          .flatten(1)
      end

      private

      def encode_letter_from_text
        @encoded_text = \
          @text
            .split('')
            .map { |letter|  Letter.new(letter.to_s.upcase, on: @on, off: @off).to_a_row }
            .reduce { |memo, letter_rows| combine_letter_pixels memo, letter_rows }
      end

      def combine_letter_pixels(source, target)
        # combine each letter pixels. 
        # Pixel row size equal to number of character times row size.
        # for e.g. 'ABC' has total 3 * 8 = 24 pixels row size
        source
          .zip(target)
          .map { |pixel_group| pixel_group.flatten(1) }
      end

      def shift_and_pad_pixels(pixel_row, position)
        # shift pixels based on position
        pixel_row.shift(position)
        pixel_row.tap do |pixels|
          # auto fill empty pixels if row of pixels less than row size
          if pixels.size < ROW_SIZE
            (ROW_SIZE - pixels.size).times { pixels << EMPTY_PIXEL }
          end
        end
      end
    end
  end
end
