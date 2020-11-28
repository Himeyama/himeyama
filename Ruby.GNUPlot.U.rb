require "numo/gnuplot"
require "numo/narray"
include Numo

class GNUPlot
    def initialize
        @plt = []
        @font_family = "Alial"
        @font_size = 18
        @key_font_size = 16
        @text_color = "212121"
        @light_gray = "E0E0E0"
        @ratio = 3r/4
        @grid = true
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
    @@colors = ["2196F3", "FF9800", "009688", "f44336"]
    @@n = 0
    
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
        opt["lc"] = "rgb 0x#{@@colors[@@n]}"
        opt["t"] = @title if @title
        @@n += 1
        [@x, @y, opt]
    end
    
    def width(w)
        @width = w
        self
    end
    
    def pt(pt)
        @pt = pt
        self
    end
    
    def title(t)
        @title = t
        self
    end
    
    attr_accessor :x, :y, :line, :point
end


x = Numo::Int32[-10..10] / 10.0
y1 = x 
y2 = x ** 2
y3 = x ** 3
y4 = x ** 4

plt = GNUPlot.new

d1 = GNUPlotData.new(x, y1).width(3).pt(5).title("x")
d2 = GNUPlotData.new(x, y2).width(3).pt(7).title("x^2")
d3 = GNUPlotData.new(x, y3).width(3).pt(5).title("x^3")
d4 = GNUPlotData.new(x, y4).width(3).pt(7).title("x^4")

plt.data = d1, d2, d3, d4

plt.xlabel = "横軸"
plt.ylabel = "縦軸"
plt.title = "タイトル"
plt.display
