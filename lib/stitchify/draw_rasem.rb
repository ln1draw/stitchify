class DrawRasem

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

            for line_data in rasem_obj.grid
                line line_data[0], line_data[1], line_data[2], line_data[3], :stroke_width=>line_data[5]
            end

            for pixel in rasem_obj.px_arr
                pos_x = rasem_obj.pos_x
                pos_y = rasem_obj.pos_y
                px = rasem_obj.px

                case pixel.shape
                when 'rectangle'
                    rectangle pos_x, pos_y, px, px, fill: pixel.hex
                when 'x'
                    line pos_x, pos_y, pos_x + px, pos_y + px
                    line pos_x, pos_y + px, pos_x + px, pos_y
                when 'circle'
                    circle (pos_x + px/2), (pos_y + px/2), px / 2 - 1, fill: pixel.hex
                when 'sm_rectangle'
                    rectangle pos_x + 1, pos_y + 1, px - 2, px - 2, fill: pixel.hex
                when 'triangle'
                    polygon [pos_x + px/2, pos_y + 1], [pos_x + 1, pos_y + px - 1], [pos_x + px - 1, pos_y + px - 1], fill: pixel.hex
                when 'diamond'
                    polygon [pos_x + px/2, pos_y + 1], [pos_x + 1, pos_y + px/2], [pos_x + px/2, pos_y + px - 1], [pos_x + px - 1, pos_y + px/2], fill: pixel.hex
                when 'reverse_triangle'
                    polygon [pos_x + px/2, pos_y + px - 1], [pos_x + 1, pos_y + 1], [pos_x + px - 1, pos_y + 1], fill: pixel.hex
                when 'left_triangle'
                    polygon [pos_x + 1, pos_y + px/2], [pos_x + px - 1, pos_y + 1], [pos_x + px - 1, pos_y + px - 1], fill: pixel.hex
                when 'right_triangle'
                    polygon [pos_x + px - 1, pos_y + px/2], [pos_x + 1, pos_y + 1], [pos_x + 1, pos_y + px - 1], fill: pixel.hex
                else
                    rectangle pos_x, pos_y, px, px, fill: pixel.hex
                end

                rasem_obj.update_positions
            end
        end
    end

    def grid
        n = 10
        output = []
        (self.width + 1).times do |i|
            x = 1
            x = 2 if (i % 10 == 0)
            output << [(i + 1) * self.px, self.px, (i + 1) * self.px, (self.width + 1) * self.px, 'black', x]
        end
        (self.width + 1).times do |i|
            x = 1
            x = 2 if i % 10 == 0
            output << [self.px, (i + 1) * self.px, (self.width + 1) * self.px, (i + 1) * self.px, 'black', x]
        end
        output
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