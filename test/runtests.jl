using SafeTestsets

@safetestset "Aqua" begin
    using PlotlyExtensionsHelper
    using Aqua
    Aqua.test_all(PlotlyExtensionsHelper)
end

@safetestset "Extensions loading" begin
    using PlotlyExtensionsHelper
    using Test

    @test_throws "No Plotly package has been loaded, make sure to load either PlotlyBase, PlotlyJS or PlutoPlotly" plotly_plot(rand(5))

    import PlotlyBase
    @test plotly_plot(rand(5)) isa PlotlyBase.Plot

    import PlotlyJS
    @test plotly_plot(rand(5)) isa PlotlyJS.SyncPlot

    import PlutoPlotly
    @test plotly_plot(rand(5)) isa PlutoPlotly.PlutoPlot
end