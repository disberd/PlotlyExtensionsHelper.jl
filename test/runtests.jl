using TestItemRunner

@testitem "Aqua" begin
    using PlotlyExtensionsHelper
    using Aqua
    Aqua.test_all(PlotlyExtensionsHelper)
end

@testitem "Extensions loading" begin
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

@testitem "colorscale_utilities" begin
    using ColorSchemes
    using ColorSchemes.Colors
    using ColorSchemes.ColorTypes
    using PlotlyExtensionsHelper: sample_colorscheme, discrete_colorscale
    cs = sample_colorscheme(:viridis)
    @test length(cs) === 256
    @test cs.colors isa Vector{<:RGBA}
    @test all(c -> c.alpha == 1.0, cs.colors)

    css = sample_colorscheme(cs, 10; alpha = 0.5)
    @test length(css) === 10
    @test all(c -> c.alpha == 0.5, css.colors)

    @test_throws "must be a valid key" sample_colorscheme(:parula)

    # discrete_colorscale
    dcs = discrete_colorscale(cs, 10)
    @test length(dcs) === 10 * 2
    @test dcs isa Vector{Tuple{Float64, String}}
end

@run_package_tests verbose=true