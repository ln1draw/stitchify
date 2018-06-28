class DrawRasem
    require 'rasem'
    # require 'pixelfy'

    attr_accessor :px_arr, :width, :px, :pos_x, :pos_y, :height

    def initialize(px_arr, width=50, px=10)
        self.px_arr = px_arr
        self.width = width
        self.px = px
        clear_vars
    end

    def stitch
        write(build_rasem_data, file='stitchify.svg')
        clear_vars
    end

    def clear_vars
        self.pos_x = self.px
        self.pos_y = self.px
    end

    def write(rasem, file)
        File.open(file, "w") do |f|
            rasem.write(f)
        end
    end

    def build_rasem_data
        rasem_obj = self

        Rasem::SVGImage.new(width: 1000000000, height: 100000000) do
            for pixel in rasem_obj.px_arr
                rectangle rasem_obj.pos_x, rasem_obj.pos_y, rasem_obj.px, rasem_obj.px, fill: pixel.hex
                rasem_obj.update_positions
            end
        end
    end

    def update_positions
        if (self.pos_x / self.px) < self.width
            self.pos_x = self.pos_x + self.px
        else
            self.pos_x = self.px
            self.pos_y = self.pos_y + self.px
        end
    end
end

s = Stitchifier.new('http://www.ellenwondra.com/MYFACE.jpg', 30, 5, 10)
