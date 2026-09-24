module PlutoPlotlyExtensionModule
    import PlutoPlotly
    import PlotlyExtensionsHelper

    __init__() = PlotlyExtensionsHelper.register_plot_func!(:PlutoPlotly, PlutoPlotly.plot; priority = 20)
end
