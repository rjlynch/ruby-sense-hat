require 'fileutils'
RSpec.describe SenseHat::Display do
  let :spec_path do
    File.join File.dirname(__FILE__), '..'
  end

  let :spec_fixtures_path do
    File.join spec_path, 'fixtures'
  end

  let :spec_file_system_path do
    File.join spec_fixtures_path,'file_system'
  end

  let :spec_tmp_path do
    File.join spec_path, 'tmp'
  end

  let :frame_buffer_names_paths do
    File.join spec_tmp_path, 'sys', 'class', 'graphics'
  end

  let :dev_path do
    File.join spec_tmp_path, 'dev'
  end

  # Copy our fake file system layout to a tmp dir for the spec run
  before :each do
    FileUtils.copy_entry spec_file_system_path, spec_tmp_path
  end

  # Clean up the tmp dir
  after :each do
    FileUtils.remove_dir(spec_tmp_path)
  end

  # Point the display at our tmp fake file system
  before do
    allow(SenseHat::Display::Device).to \
      receive(:frame_buffer_names_paths) { frame_buffer_names_paths + '/fb*' }

    allow(SenseHat::Display::Device).to receive(:dev_path) { dev_path }
  end

  context '#set_pixels' do
    let(:display) { described_class.new }

    context 'not enough pixels' do
      let(:pixel_list) { Array.new(62) { [0, 0, 0] } + [[255, 255, 255]] }

      it 'raises' do
        expect { display.set_pixels(pixel_list) }.to \
          raise_error SenseHat::ValueError, 'Pixel lists must have 64 elements'
      end
    end

    context 'invalid pixels' do
      let(:pixel_list) { Array.new(63) { [0, 0, 0] } + [[400, 255, 255]] }

      it 'raises' do
        expect { display.set_pixels(pixel_list) }.to \
          raise_error SenseHat::ValueError, \
            'rgb out off bounds <#pixel index=63 red=400 green=255 blue=255>'
      end
    end

    context 'valid pixels' do
      let(:pixel_list) { Array.new(63) { [0, 0, 0] } + [[255, 0, 0]] }

      let :last_pixel_red do
        File.binread(File.join(spec_fixtures_path, 'last_pixel_red.bin'))
      end

      before do
        display.set_pixels pixel_list
      end

      it 'updates the device with the correct pixels' do
        expect(File.binread(File.join(dev_path, 'fb1'))).to eq last_pixel_red
      end
    end
  end
end
