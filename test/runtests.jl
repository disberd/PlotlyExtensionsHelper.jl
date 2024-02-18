using SafeTestsets

@safetestset "Extensions loading" begin
    using PlotlyExtensionsHelper
    using PlotlyBase
    using Test

    @test plotly_plot(rand(5)) isa PlotlyBase.Plot

    using PlutoPlotly

    @test plotly_plot(rand(5)) isa PlutoPlot
end