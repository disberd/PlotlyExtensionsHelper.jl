module PlotlyExtensionsHelper

export plotly_plot

const PLOT_FUNC_PRIORITY = [:PlutoPlotly, :PlotlyJS, :PlotlyBase]
_plot_func(@nospecialize(::Val)) = nothing

"""
    plotly_plot(args...;kwargs...)

This function will forward args... and kwargs... to the relevant `plot` function
of the loaded Plotly packages, based on the priority specified in
`PlotlyExtensionHelper.PLOT_FUNC_PRIORITY`.

It is intended to be used inside extensions to produce output of plotting function based on one of the supported Plotly based packages (i.e. PlotlyBase, PlotlyJS or PlutoPlotly)
"""
function plotly_plot(args...;kwargs...)
    for key in PLOT_FUNC_PRIORITY
        f = _plot_func(Val(key))
        isnothing(f) && continue
        return f(args...;kwargs...)
    end
    error("No Plotly package has been loaded, make sure to load either PlotlyBase, PlotlyJS or PlutoPlotly")
end

end
