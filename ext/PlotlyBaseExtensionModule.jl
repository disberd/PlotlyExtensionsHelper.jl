module PlotlyBaseExtensionModule
    import PlotlyBase
    import PlotlyExtensionsHelper

    # Load the function for PlotlyBase
    PlotlyExtensionsHelper._plot_func(::Val{:PlotlyBase}) = PlotlyBase.Plot
end