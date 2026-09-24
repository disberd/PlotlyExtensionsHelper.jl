module PlotlyJSExtensionModule
    import PlotlyJS
    import PlotlyExtensionsHelper

    __init__() = PlotlyExtensionsHelper.register_plot_func!(:PlotlyJS, PlotlyJS.plot; priority = 10)
end
