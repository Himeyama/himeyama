require "numo/gnuplot"
require "numo/narray"
include Numo

class GNUPlot
    def initialize(
    plt = nil, 
    title = nil,
    file_name = nil, 
    font_family = "Alial", 
    font_size = 18, 
    key_font_size = 16, 
    text_color = "212121",
    colors = ["2196F3", "FF9800", "009688", "f44336"],
    light_gray = "E0E0E0",
    ratio = 3r/4,
    grid = true,
    xlabel = nil,
    ylabel = nil)
        @plt = plt
        @title = title
        @file_name = file_name
        @font_family = font_family
        @font_size = font_size
        @key_font_size = key_font_size
        @text_color = text_color
        @colors = colors
        @light_gray = light_gray
        @ratio = ratio
        @grid = grid
        @xlabel = xlabel
        @ylabel = ylabel
    end
    
    def display
        key_font_size = @key_font_size
        obj = self
        Numo::Gnuplot::NotePlot.new do
            set *{title: (obj.title if obj.title), font: "#{obj.font_family}, #{obj.font_size}"}
            set *{output: obj.file_name} if obj.file_name
            set *{size: "", ratio: obj.ratio.to_f}
            set *{border: "", lc: "rgb 0x#{obj.text_color}"}
            set *{tics: "", font: "#{obj.font_family}, #{obj.font_size}"}
            set *{xlabel: (obj.xlabel if obj.xlabel), font: "#{obj.font_family}, #{obj.font_size}"}
            set *{ylabel: (obj.ylabel if obj.ylabel), font: "#{obj.font_family}, #{obj.font_size}"}
            set *{key: "", width: 2, outside: "", opaque: "", box: "", lw: 2, lc: "rgb 0x#{obj.light_gray}", font:"#{obj.font_family}, #{obj.key_font_size}", tc: "rgb 0x#{obj.text_color}"}
            set "grid" if obj.grid
            plot *obj.plt
        end
    end
    
    attr_accessor :grid, :ratio, :text_color, :plt, :font_family, :font_size, :light_gray, :key_font_size, :file_name, :xlabel, :ylabel, :title
end

x = Numo::Int32[-10..10] / 10.0
y = x 
y2 = x ** 2
y3 = x ** 3
y4 = x ** 4

plt = GNUPlot.new
plt.plt = [x, y, {w: "lp", pt: 5, lw: 3, lc: "rgb 0x#{colors[0]}", t: "x"},
                x, y2, {w: "lp", pt: 7, lw: 3, lc: "rgb 0x#{colors[1]}", dt: "(5, 1)", t: "x^2"},
                x, y3, {w: "lp", pt: 5, lw: 3, lc: "rgb 0x#{colors[2]}", dt: "(3, 1)", t: "x^3"},
                x, y4, {w: "lp", pt: 7, lw: 3, lc: "rgb 0x#{colors[3]}", t: "x^4"}]
plt.xlabel = "横軸"
plt.ylabel = "縦軸"
plt.title = "タイトル"
plt.display
