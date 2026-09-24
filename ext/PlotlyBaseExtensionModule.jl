module PlotlyBaseExtensionModule
    import PlotlyBase
    import PlotlyExtensionsHelper

    __init__() = PlotlyExtensionsHelper.register_plot_func!(:PlotlyBase, PlotlyBase.Plot; priority = 0)
end
