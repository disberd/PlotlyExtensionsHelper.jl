module PlotlyBaseExt
    using PlotlyExtensionsHelper
    using PlotlyBase
    import ExamplePackage

    function ExamplePackage.plot_4_lines()
        data = map(1:4) do i
            scatter(;y = rand(10), name = "line $i")
        end
        layout = Layout(;
            template = "none",
            title = "My nice 4 lines",
            xaxis_title = "Iteration",
            yaxis_title = "Value",
        )
        return plotly_plot(data, layout)
    end
end