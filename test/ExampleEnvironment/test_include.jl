# This file can be included to show that the `plot_4_lines` function defined in ExamplePackage and actually implemented in its PlotlyBase extension works and uses PlotlyJS to create the plot when PlotlyJS has been loaded.
import Pkg
current_proj = Base.active_project()
try
    Pkg.activate(@__DIR__)
    import PlotlyJS # This will trigger loading the extension
    using ExamplePackage
    # This will be plotted using PlotlyJS.SyncPlot (rather than PlotlyBase.Plot) as PlotlyJS is loaded and has a higher priority
    plot_4_lines()
finally
    Pkg.activate(current_proj)
end