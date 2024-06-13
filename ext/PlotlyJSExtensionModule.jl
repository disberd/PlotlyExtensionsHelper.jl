module PlotlyJSExtensionModule
    import PlotlyJS
    import PlotlyExtensionsHelper

    # Load the function for PlotlyBase
    PlotlyExtensionsHelper._plot_func(::Val{:PlotlyJS}) = PlotlyJS.plot
end