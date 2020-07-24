module SenseHat
  class Display
    CLEAR = Array.new(64) { [0, 0, 0] }

    def initialize
      @device = Device.new
    end

    # Sets the LED display to the provided rgb values
    # @param [Array<Array><Int>] 64 element 2d array of pixels. The elements of
    # the sub arrays are 3 element arrays of integers in the range 0..255
    # representing the RGB colour values of a pixel
    # eg: [[255, 255, 255], [255, 200, 200], ... [100, 143, 200]]
    def set_pixels(pixel_list)
      unless pixel_list.size == 64
        fail ValueError, 'Pixel lists must have 64 elements'
      end

      @device.write encode(pixel_list)
    end

    # Returns the RGB values of the pixels on the LED display.
    # Due to the rgb565 encoding red and blue values are capped at 248 and
    # green is capped at 252. See this for a good explanation:
    # https://stackoverflow.com/questions/25467682/rgb-565-why-6-bits-for-green-color
    #
    # @return [Array<Array><Int>] 64 element array of 3 element integer arrays.
    def get_pixels
      decode @device.read
    end

    # Clears the LED display by setting all pixels to 0, 0, 0 RGB
    def clear
      set_pixels CLEAR
    end

    private

    def encode(array)
      array
        .map(&Pixel.method(:new_from_array))
        .each(&:validate!)
        .map(&:rgb565)
        .map { |rgb565| rgb565.pack('S') }
        .join
    end

    def decode(string)
      string
        .unpack('S' * 64)
        .map(&Pixel.method(:new_from_rgb565))
        .map(&:to_a)
    end
  end
end
