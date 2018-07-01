class DrawRasem

    attr_accessor :px_arr, :width, :px, :pos_x, :pos_y, :height, :color_set

    def initialize(px_arr, width=50, px=10, color_set=[])
        self.px_arr = px_arr
        self.width = width
        self.px = px
        self.color_set = color_set
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

            group stroke: 'black' do
                for line_data in rasem_obj.grid
                    line line_data[0], line_data[1], line_data[2], line_data[3], :stroke_width=>line_data[5]
                end
            end

            for pixel in rasem_obj.px_arr
                pos_x = rasem_obj.pos_x
                pos_y = rasem_obj.pos_y
                px = rasem_obj.px
                a = px / 4
                b = px / 2
                c = px - a
                d = a / 2

                case pixel.shape
                when 'rectangle'
                    rectangle pos_x, pos_y, px, px, fill: pixel.hex
                when 'x'
                    line pos_x, pos_y, pos_x + px, pos_y + px
                    line pos_x, pos_y + px, pos_x + px, pos_y
                when 'circle'
                    circle (pos_x + b), (pos_y + b), a + d, fill: pixel.hex
                when 'sm_rectangle'
                    rectangle pos_x + a + 1, pos_y + a + 1, b, b, fill: pixel.hex
                when 'triangle'
                    polygon [pos_x + b, pos_y + a], 
                            [pos_x + c, pos_y + c],
                            [pos_x + a, pos_y + c], fill: pixel.hex
                when 'diamond'
                    polygon [pos_x + b,      pos_y + 1], 
                            [pos_x + 1,      pos_y + b], 
                            [pos_x + b,      pos_y + px - 1], 
                            [pos_x + px - 1, pos_y + b], fill: pixel.hex
                when 'reverse_triangle'
                    polygon [pos_x + a, pos_y + a], 
                            [pos_x + c, pos_y + a], 
                            [pos_x + b, pos_y + c], fill: pixel.hex
                when 'left_triangle'
                    polygon [pos_x + a, pos_y + b],
                            [pos_x + c, pos_y + a],
                            [pos_x + c, pos_y + c], fill: pixel.hex
                when 'right_triangle'
                    polygon [pos_x + a, pos_y + a],
                            [pos_x + c, pos_y + b],
                            [pos_x + a, pos_y + c] , fill: pixel.hex
                when 'star'
                    polygon [pos_x + a + 1,  pos_y + 1], 
                            [pos_x + b,      pos_y + a + 1],
                            [pos_x + c - 1,  pos_y + 1],
                            [pos_x + c - 1,  pos_y + a + 1],
                            [pos_x + px - 1, pos_y + a + 1],
                            [pos_x + c - 1,  pos_y + b],
                            [pos_x + px - 1, pos_y + c - 1],
                            [pos_x + c - 1,  pos_y + c - 1],
                            [pos_x + c - 1,  pos_y + px - 1],
                            [pos_x + b,      pos_y + c - 1],
                            [pos_x + a + 1,  pos_y + px - 1],
                            [pos_x + a + 1,  pos_y + c - 1],
                            [pos_x + 1,      pos_y + c - 1],
                            [pos_x + a + 1,  pos_y + b],
                            [pos_x + 1,      pos_y + a + 1],
                            [pos_x + a + 1,  pos_y + a + 1],
                            [pos_x + a + 1,  pos_y + 1], fill: pixel.hex
                when 'heart'
                    polygon [pos_x + a, pos_y + a],
                            [pos_x + b - d, pos_y + a],
                            [pos_x + b, pos_y + b - d],
                            [pos_x + b + d, pos_y + a],
                            [pos_x + c, pos_y + a],
                            [pos_x + c, pos_y + b],
                            [pos_x + b, pos_y + c],
                            [pos_x + a, pos_y + b], fill: pixel.hex
                else
                    rectangle pos_x, pos_y, px, px, fill: pixel.hex
                end

                rasem_obj.update_positions
            end

            group stroke: 'black' do
                legend_pos_x = (rasem_obj.width + 2) * px
                legend_pos_y = 2 * px
                legend_height = px * rasem_obj.color_set.length
                rectangle legend_pos_x, legend_pos_y, 10 + px, legend_height, fill: 'white'
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