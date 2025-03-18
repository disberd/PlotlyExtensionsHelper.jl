"""
    sample_colorscheme(cs::ColorScheme, sample_points::AbstractVector; alpha = nothing)
    sample_colorscheme(cs::ColorScheme, npoints::Int = length(cs); alpha = nothing)
    sample_colorscheme(cs_name::Symbol, args...; alpha = nothing)

Function to create a reduced sampled version of the provided colorscheme `cs`, optionally specifying the opacity of the colors using the `alpha` keyword argument.

The `sample_points` argument can be provided as a vector of points in the range [0, 1] to sample the colorscheme at specific points, or as an integer `npoints` to sample the colorscheme at `npoints` evenly spaced points in the range [0, 1].

Instead of being called with an explicit `ColorScheme` object, the function can also be called with a `Symbol` which is used to extract the corresponding `ColorScheme` object from the `colorschemes` Dict in the `ColorSchemes.jl` package.
"""
function sample_colorscheme end

"""
    discrete_colorscale(cs::Union{ColorScheme, Symbol}, points; alpha = nothing)
    discrete_colorscale(colors::AbstractVector{<:Colorant})

Function to create a discrete colorscale from a colorscheme or a vector of colors, specifically intended for use as the `colorscale` attribute of a plotlyjs plot.

The function will assume that the resulting colorscale will have evenly spaced mapping between the colors in the vector and the corresponding plotly colorscale.
As example, when providing a vector of 3 colors as input, the resulting colorscale will assign each of the 3 colors to 33% of the values of the colorbar/coloraxis.

This is useful for creating heatmaps where values are mapped to a few number of colors rather than to a continuous gradient.

When called with a `ColorScheme` or `Symbol` as first argument, the colors are first sampled using the `sample_colorscheme` function, and then converted to a discrete colorscale.

```jldoctest
julia> using PlutoPlotly;

julia> colorscale = discrete_colorscale(:viridis, 5)
10-element Vector{Tuple{Float64, String}}:
 (0.0, "rgba(68,1,84,1.0)")
 (0.2, "rgba(68,1,84,1.0)")
 (0.2, "rgba(59,82,139,1.0)")
 (0.4, "rgba(59,82,139,1.0)")
 (0.4, "rgba(33,144,140,1.0)")
 (0.6, "rgba(33,144,140,1.0)")
 (0.6, "rgba(93,201,99,1.0)")
 (0.8, "rgba(93,201,99,1.0)")
 (0.8, "rgba(253,231,37,1.0)")
 (1.0, "rgba(253,231,37,1.0)")

julia> plot(heatmap(; z = rand(10,10), colorscale))
```
"""
function discrete_colorscale end
