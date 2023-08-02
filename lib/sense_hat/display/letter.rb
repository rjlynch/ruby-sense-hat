module SenseHat
  class Display
    class Letter
      MAPS = {
          'A' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X X X X X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          TEXT
          'B' => <<~TEXT,
          . . . . . . . .
          . X X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X X X X . . .
          TEXT
          'C' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          'D' => <<~TEXT,
          . . . . . . . .
          . X X X . . . .
          . X . . X . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . X . . .
          . X X X . . . .
          TEXT
          'E' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . X . . . . . .
          . X . . . . . .
          . X X X X . . .
          . X . . . . . .
          . X . . . . . .
          . X X X X X . .
          TEXT
          'F' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . X . . . . . .
          . X . . . . . .
          . X X X X . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          TEXT
          'G' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . . . .
          . X . X X X . .
          . X . . . X . .
          . X . . . X . .
          . . X X X X . .
          TEXT
          'H' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X X X X X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          TEXT
          'I' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . X X X . . .
          TEXT
          'J' => <<~TEXT,
          . . . . . . . .
          . . . X X X . .
          . . . . X . . .
          . . . . X . . .
          . . . . X . . .
          . . . . X . . .
          . X . . X . . .
          . . X X . . . .
          TEXT
          'K' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . X . . .
          . X . X . . . .
          . X X . . . . .
          . X . X . . . .
          . X . . X . . .
          . X . . . X . .
          TEXT
          'L' => <<~TEXT,
          . . . . . . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          . X X X X X . .
          TEXT
          'M' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X X . X X . .
          . X . X . X . .
          . X . X . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          TEXT
          'N' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . X X . . X . .
          . X . X . X . .
          . X . . X X . .
          . X . . . X . .
          . X . . . X . .
          TEXT
          'O' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          'P' => <<~TEXT,
          . . . . . . . .
          . X X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X X X X . . .
          . X . . . . . .
          . X . . . . . .
          . X . . . . . .
          TEXT
          'Q' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . X . X . .
          . X . . X . . .
          . . X X . X . .
          TEXT
          'R' => <<~TEXT,
          . . . . . . . .
          . X X X X . . .
          . X . . . X . .
          . X . . . X . .
          . X X X X . . .
          . X . X . . . .
          . X . . X . . .
          . X . . . X . .
          TEXT
          'S' => <<~TEXT,
          . . . . . . . .
          . . X X X X . .
          . X . . . . . .
          . X . . . . . .
          . . X X X . . .
          . . . . . X . .
          . . . . . X . .
          . X X X X . . .
          TEXT
          'T' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          TEXT
          'U' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          'V' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . . X . X . . .
          . . . X . . . .
          TEXT
          'W' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . X . . . X . .
          . X . X . X . .
          . X . X . X . .
          . X X . X X . .
          . X . . . X . .
          TEXT
          'X' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . . X . X . . .
          . . . X . . . .
          . . X . X . . .
          . X . . . X . .
          . X . . . X . .
          TEXT
          'Y' => <<~TEXT,
          . . . . . . . .
          . X . . . X . .
          . X . . . X . .
          . . X . X . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          TEXT
          'Z' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . . . . . X . .
          . . . . X . . .
          . . . X . . . .
          . . X . . . . .
          . X . . . . . .
          . X X X X X . .
          TEXT
          '0' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X X . . X . .
          . X . X . X . .
          . X . . X X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          '1' => <<~TEXT,
          . . . . . . . .
          . . . X . . . .
          . . X X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . X X X . . .
          TEXT
          '2' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . . . . . X . .
          . . . . X . . .
          . . . X . . . .
          . . X . . . . .
          . X X X X X . .
          TEXT
          '3' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . . . . X . . .
          . . . X . . . .
          . . . . X . . .
          . . . . . X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          '4' => <<~TEXT,
          . . . . . . . .
          . . . . X . . .
          . . . X X . . .
          . . X . X . . .
          . X . . X . . .
          . X X X X X . .
          . . . . X . . .
          . . . . X . . .
          TEXT
          '5' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . X . . . . . .
          . X X X X . . .
          . . . . . X . .
          . . . . . X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          '6' => <<~TEXT,
          . . . . . . . .
          . . . X X . . .
          . . X . . . . .
          . X . . . . . .
          . X X X X . . .
          . X . . . X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          '7' => <<~TEXT,
          . . . . . . . .
          . X X X X X . .
          . . . . . X . .
          . . . . X . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          . . . X . . . .
          TEXT
          '8' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . X . .
          . . X X X . . .
          . X . . . X . .
          . X . . . X . .
          . . X X X . . .
          TEXT
          '9' => <<~TEXT,
          . . . . . . . .
          . . X X X . . .
          . X . . . X . .
          . X . . . X . .
          . . X X X X . .
          . . . . . X . .
          . . . . X . . .
          . . X X . . . .
          TEXT
          ' ' => <<~TEXT
          . . . . . . . .
          . . . . . . . .
          . . . . . . . .
          . . . . . . . .
          . . . . . . . .
          . . . . . . . .
          . . . . . . . .
          . . . . . . . .
          TEXT
      }.freeze

      ON = 'X'.freeze
      OFF = '.'.freeze

      def initialize(letter, on:, off:)
        @letter = letter
        @on = on
        @off = off
      end

      def to_a
        MAPS
          .fetch(@letter)
          .split('')
          .select { |c| [ON, OFF].include? c  }
          .map { |c| c == ON ? @on : @off }

      rescue KeyError => e
        raise  LetterNotSupported, <<~TEXT
          Letter not supported '#{@letter}'.
          Only #{MAPS.keys} supported
          TEXT
      end

      def to_a_row(row: 8)
        # convert to 8 x 8 array list to be used on Text class.
        pixels = to_a
        [].tap do |pixels_row|
          while pixels.size > 0
            pixels_row << pixels.slice!(0, row)
          end
        end
      end
    end
  end
end
