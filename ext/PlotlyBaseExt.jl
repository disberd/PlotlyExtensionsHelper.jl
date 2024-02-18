module PlotlyBaseExt
    using PlotlyBase
    using PlotlyExtensionsHelper

    # Load the function for PlotlyBase
    PlotlyExtensionsHelper._plot_func(::Val{:PlotlyBase}) = PlotlyBase.Plot
end