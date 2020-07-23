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

      pixels = pixel_list.each_with_index.map do |rgb, i|
        Pixel.new(position: i, red: rgb[0], green: rgb[1], blue: rgb[2])
      end

      pixels.each(&:validate!)

      @device.write pixels.sort_by(&:position).map(&:rgb565).join
    end

    # Returns the RGB values of the pixels on the LED display.
    # Due to the rgb565 encoding red and blue values are capped at 248 and
    # green is capped at 252. See this for a good explanation:
    # https://stackoverflow.com/questions/25467682/rgb-565-why-6-bits-for-green-color
    #
    # @return [Array<Array><Int>] 64 element array of 3 element integer arrays.
    def get_pixels
      raw = @device.read
      values = raw.unpack('S' * 64)
      values
        .each_with_index
        .map { |value, i| Pixel.new_from_rgb565(position: i, rgb565: value) }
        .map(&:to_a)
    end

    # Clears the LED display by setting all pixels to 0, 0, 0 RGB
    def clear
      set_pixels CLEAR
    end
  end
end
