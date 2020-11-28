require "numo/gnuplot"
require "numo/narray"
include Numo

class GNUPlot
    def initialize(
    plt = [], 
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
    
    def add_data(dat)
        @plt += dat.get
    end
    
    def data=(data)
        data.each do |d|
            add_data(d)
        end
    end
    
    attr_accessor :grid, :ratio, :text_color, :plt, :font_family, :font_size, :light_gray, :key_font_size, :file_name, :xlabel, :ylabel, :title
end

class GNUPlotData
    def initialize(x, y) 
        @x = x
        @y = y
        @line = true
        @point = true
        @width = 1
        @title = nil
    end
    
    def get
        opt = {}
        if line
            opt["w"] = "l"
            opt["lw"] = @width
        end
        if point
            opt["w"] = "p"
            opt["pt"] = @pt
        end
        opt["w"] = "lp" if line && point
        opt["t"] = @title if @title
        opt["lc"] = "rgb 0x#{@color}" if @color
        
        [@x, @y, opt]
    end
    
    def width(w)
        @width = w
        self
    end
    
    def color(c)
        @color = c
        self
    end
    
    def pt(pt)
        @pt = pt
        self
    end
    
    attr_accessor :x, :y, :line, :point, :title
end

colors = ["2196F3", "FF9800", "009688", "f44336"]


x = Numo::Int32[-10..10] / 10.0
y1 = x 
y2 = x ** 2
y3 = x ** 3
y4 = x ** 4

plt = GNUPlot.new

d1 = GNUPlotData.new(x, y1).width(3).color(colors[0]).pt(5)
d2 = GNUPlotData.new(x, y2).width(3).color(colors[1]).pt(7)
d3 = GNUPlotData.new(x, y3).width(3).color(colors[2]).pt(5)
d4 = GNUPlotData.new(x, y4).width(3).color(colors[3]).pt(7)

plt.data = d1, d2, d3, d4

plt.xlabel = "横軸"
plt.ylabel = "縦軸"
plt.title = "タイトル"
plt.display
