using TestItemRunner

@testitem "Aqua" begin
    using PlotlyExtensionsHelper
    using Aqua
    Aqua.test_all(PlotlyExtensionsHelper)
end

@testitem "Extensions loading" begin
    using PlotlyExtensionsHelper
    using Test

    @test_throws "No Plotly package has been loaded" plotly_plot(rand(5))

    import PlotlyBase
    @test plotly_plot(rand(5)) isa PlotlyBase.Plot

    import PlotlyJS
    @test plotly_plot(rand(5)) isa PlotlyJS.SyncPlot

    import PlutoPlotly
    @test plotly_plot(rand(5)) isa PlutoPlotly.PlutoPlot

    # Keep the registry checks in this item. A separate item can run first and load a backend, which breaks the first check above.
    using PlotlyExtensionsHelper: PLOT_FUNCS, PLOT_FUNC_PRIORITY, register_plot_func!, apply_priority_preference!
    saved_funcs, saved_priority = copy(PLOT_FUNCS), copy(PLOT_FUNC_PRIORITY)
    try
        # The backend with the highest priority wins
        register_plot_func!(:High, (args...; kwargs...) -> :high; priority = 30)
        register_plot_func!(:Low, (args...; kwargs...) -> :low; priority = -1)
        @test plotly_plot(rand(5)) === :high

        # A change to PLOT_FUNC_PRIORITY changes the selected backend
        PLOT_FUNC_PRIORITY[:Low] = 50
        @test plotly_plot(rand(5)) === :low

        # For equal priorities, the name that sorts first wins
        PLOT_FUNC_PRIORITY[:High] = 50
        @test plotly_plot(rand(5)) === :high

        # A priority set before the registration stays
        PLOT_FUNC_PRIORITY[:Late] = -10
        register_plot_func!(:Late, (args...; kwargs...) -> :late; priority = 100)
        @test PLOT_FUNC_PRIORITY[:Late] == -10
        @test plotly_plot(rand(5)) === :high

        # The preference keeps the integer entries and ignores the other entries
        @test_logs (:warn, r"must be an integer") apply_priority_preference!(Dict("Late" => 200, "Bad" => "x"))
        @test PLOT_FUNC_PRIORITY[:Late] == 200
        @test !haskey(PLOT_FUNC_PRIORITY, :Bad)
        @test plotly_plot(rand(5)) === :late

        # A preference that is not a table changes nothing
        @test_logs (:warn, r"must be a table") apply_priority_preference!(3)
        @test PLOT_FUNC_PRIORITY[:Late] == 200
    finally
        copy!(PLOT_FUNCS, saved_funcs)
        copy!(PLOT_FUNC_PRIORITY, saved_priority)
    end
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