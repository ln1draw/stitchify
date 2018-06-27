class DrawRasem
    require 'rasem'

    attr_accessor :hex_arr, :width, :px, :pos_x, :pos_y, :height

    def initialize(hex_arr, width=50, px=10)
        self.hex_arr = hex_arr
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
            for hex_data in rasem_obj.hex_arr
                circle rasem_obj.pos_x, rasem_obj.pos_y, rasem_obj.px / 2, fill: hex_data
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
