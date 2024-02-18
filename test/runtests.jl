using SafeTestsets

@safetestset "Extensions loading" begin
    using PlotlyExtensionsHelper
    using Test

    @test_throws "No Plotly package has been loaded, make sure to load either PlotlyBase or PlutoPlotly" plotly_plot(rand(5))

    using PlotlyBase
    @test plotly_plot(rand(5)) isa PlotlyBase.Plot

    using PlutoPlotly
    @test plotly_plot(rand(5)) isa PlutoPlot
end