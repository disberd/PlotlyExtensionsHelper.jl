module PlutoPlotlyExt
    import PlutoPlotly
    using PlotlyExtensionsHelper

    # Load the function for PlutoPlotly
    PlotlyExtensionsHelper._plot_func(::Val{:PlutoPlotly}) = PlutoPlotly.plot
end