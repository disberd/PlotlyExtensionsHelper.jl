# PlotlyJS and PlutoPlotly limit PlotlyBase to an old version. This environment
# does not have them, so it tests the most recent PlotlyBase that the compat allows.
using Test
using PlotlyExtensionsHelper
using PlotlyBase
using ColorSchemes

@info "PlotlyBase version" pkgversion(PlotlyBase)

@testset "PlotlyBase only" begin
    @test plotly_plot(rand(5)) isa PlotlyBase.Plot

    data = [scatter(; y = rand(10), name = "line $i") for i in 1:4]
    layout = Layout(; template = "none", title = "Title", xaxis_title = "Iteration")
    p = plotly_plot(data, layout)
    @test p isa PlotlyBase.Plot
    @test length(p.data) == 4

    colorscale = PlotlyExtensionsHelper.discrete_colorscale(:viridis, 4)
    p = plotly_plot(heatmap(; z = rand(3, 3), colorscale))
    @test p.data[1].colorscale == colorscale
    @test occursin("rgba(68,1,84,1.0)", PlotlyBase.JSON.json(p))
end
