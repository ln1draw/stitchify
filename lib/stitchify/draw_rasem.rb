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
            pos_x = rasem_obj.pos_x
            pos_y = rasem_obj.pos_y
            px = rasem_obj.px
            a = px / 4
            b = px / 2
            c = px - a
            d = a / 2

            defs do
                group(id: 'rectangle') do
                    rectangle pos_x, pos_y, px, px
                end

                group(id: 'x') do
                    line pos_x, pos_y, pos_x + px, pos_y + px
                    line pos_x, pos_y + px, pos_x + px, pos_y
                end

                group(id: 'circle') do
                    circle (pos_x + b), (pos_y + b), a + d
                end

                group(id: 'sm_rectangle') do
                    rectangle pos_x + a + 1, pos_y + a + 1, b, b
                end

                group(id: 'triangle') do
                    polygon [pos_x + b, pos_y + a], 
                            [pos_x + c, pos_y + c],
                            [pos_x + a, pos_y + c]
                end

                group(id: 'diamond') do
                    polygon [pos_x + b,      pos_y + 1], 
                            [pos_x + 1,      pos_y + b], 
                            [pos_x + b,      pos_y + px - 1], 
                            [pos_x + px - 1, pos_y + b]
                end

                group(id: 'reverse_triangle') do
                    polygon [pos_x + a, pos_y + a], 
                            [pos_x + c, pos_y + a], 
                            [pos_x + b, pos_y + c]
                end

                group(id: 'left_triangle') do
                    polygon [pos_x + a, pos_y + b],
                            [pos_x + c, pos_y + a],
                            [pos_x + c, pos_y + c]
                end

                group(id: 'right_triangle') do
                    polygon [pos_x + a, pos_y + a],
                            [pos_x + c, pos_y + b],
                            [pos_x + a, pos_y + c]
                end

                group(id: 'star') do
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
                            [pos_x + a + 1,  pos_y + 1]
                end

                group(id: 'heart') do
                    polygon [pos_x + a, pos_y + a],
                            [pos_x + b - d, pos_y + a],
                            [pos_x + b, pos_y + b - d],
                            [pos_x + b + d, pos_y + a],
                            [pos_x + c, pos_y + a],
                            [pos_x + c, pos_y + b],
                            [pos_x + b, pos_y + c],
                            [pos_x + a, pos_y + b]
                end
            end

            # grid
            group stroke: 'black' do
                for line_data in rasem_obj.grid
                    line line_data[0], line_data[1], line_data[2], line_data[3], :stroke_width=>line_data[5]
                end

                blocks = rasem_obj.width / 10
                blocks.times do |i|
                    text((i + 1) * 10 * px + b, c, stroke_width: 1, 'font-size': '8px', class: 'grid-numbers') { raw (i + 1) * 5 }
                    text(1, (i + 1) * 10 * px + px + a, stroke_width: 1, 'font-size': '8px', class: 'grid-numbers') { raw (i + 1) * 5 }
                end
            end

            # content
            for pixel in rasem_obj.px_arr
                use(pixel.shape, x: rasem_obj.pos_x - px, y: rasem_obj.pos_y - px, fill: pixel.hex)
                rasem_obj.update_positions
            end

            # legend
            group stroke: 'black' do
                legend_pos_x = (rasem_obj.width + 2) * px
                legend_pos_y = 2 * px
                legend_height = px * (rasem_obj.color_set.length * 2)
                rectangle legend_pos_x, legend_pos_y, 10 * px, legend_height, fill: 'white'
                rasem_obj.color_set.each_with_index do |pixel, index|
                    use(pixel.shape, x: legend_pos_x - b, y: legend_pos_y - b, fill: pixel.hex)
                    text(legend_pos_x + 2 * px, legend_pos_y + px + b) { raw pixel.hex }
                    legend_pos_y += 2 * px
                end
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