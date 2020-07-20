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

      @device.open do |f|
        f.write pixels.sort_by(&:position).map(&:rgb565).join
      end
    end

    def get_pixels
    end

    def set_pixel(pixel)
      # two bytes per pixel. 16 bit RGB565 value at file off set represents pixel.
    end

    def get_pixel
    end

    # Clears the LED display by setting all pixels to 0, 0, 0 RGB
    def clear
      set_pixels CLEAR
    end
  end
end
