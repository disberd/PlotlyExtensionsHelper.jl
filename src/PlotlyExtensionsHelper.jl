module PlotlyExtensionsHelper

using Preferences: load_preference

include("utilities.jl") # These are utilities extractd from PlutoPlotly

export plotly_plot
public register_plot_func!, PLOT_FUNC_PRIORITY, sample_colorscheme, discrete_colorscale

# ponytail: no lock, add a ReentrantLock if a package loads on one thread while another thread plots.
const PLOT_FUNCS = Dict{Symbol, Any}()

"""
    PLOT_FUNC_PRIORITY::Dict{Symbol, Int}

The priority of each plotting backend. [`plotly_plot`](@ref) uses the loaded
backend with the highest priority. If two backends have the same priority, it
uses the backend with the name that sorts first.

The default priorities are:
- `PlutoPlotly`: 20
- `PlotlyJS`: 10
- `PlotlyBase`: 0

To change a priority for all sessions, set the `plot_func_priority` preference:

```julia
using Preferences, PlotlyExtensionsHelper
set_preferences!(PlotlyExtensionsHelper, "plot_func_priority" => Dict("PlotlyJS" => 30))
```

The value from the preference replaces the default priority of the backend.
The change applies when Julia loads the package again.

To change a priority for the current session only, change the value in this `Dict`:

```julia
PlotlyExtensionsHelper.PLOT_FUNC_PRIORITY[:PlotlyJS] = 30
```
"""
const PLOT_FUNC_PRIORITY = Dict{Symbol, Int}()

function __init__()
    apply_priority_preference!(load_preference(@__MODULE__, "plot_func_priority", Dict{String, Any}()))
end

# Copy the valid entries of the `plot_func_priority` preference to `PLOT_FUNC_PRIORITY`.
function apply_priority_preference!(pref)
    if !(pref isa AbstractDict)
        @warn "The `plot_func_priority` preference must be a table of backend names and integers. PlotlyExtensionsHelper ignores it." pref
        return nothing
    end
    for (name, priority) in pref
        if priority isa Integer
            PLOT_FUNC_PRIORITY[Symbol(name)] = priority
        else
            @warn "The priority of a backend must be an integer. PlotlyExtensionsHelper ignores this entry of the `plot_func_priority` preference." name priority
        end
    end
    return nothing
end

"""
    register_plot_func!(name::Symbol, f; priority::Integer)

Register `f` as the plotting function of the backend `name`, with the default
priority `priority`. A higher value gives a higher priority.
[`plotly_plot`](@ref) forwards its arguments to `f` when `name` is the loaded
backend with the highest priority in [`PLOT_FUNC_PRIORITY`](@ref).

A priority that the user sets in `PLOT_FUNC_PRIORITY` before the registration
stays. This includes the priority from the `plot_func_priority` preference.

Call this function only from the `__init__` function of your package or extension.
The precompilation cache does not keep a registration made at top level.

# Example
```julia
module MyBackendPlotlyExtensionsHelperExt
    import MyBackend, PlotlyExtensionsHelper
    __init__() = PlotlyExtensionsHelper.register_plot_func!(:MyBackend, MyBackend.plot; priority = 15)
end
```
"""
function register_plot_func!(name::Symbol, f; priority::Integer)
    PLOT_FUNCS[name] = f
    get!(PLOT_FUNC_PRIORITY, name, priority)
    return nothing
end

"""
    plotly_plot(args...;kwargs...)

This function will forward args... and kwargs... to the plotting function of
the loaded backend with the highest priority in [`PLOT_FUNC_PRIORITY`](@ref).

It is intended to be used inside extensions to produce output of plotting function based on one of the supported Plotly based packages (i.e. PlutoPlotly, PlotlyJS or PlotlyBase).
Other packages can add a backend with [`register_plot_func!`](@ref).
"""
function plotly_plot(args...;kwargs...)
    isempty(PLOT_FUNCS) && error("No Plotly package has been loaded, make sure to load PlotlyBase, PlotlyJS, PlutoPlotly, or a package that calls `register_plot_func!`")
    # The name is the second key, so the choice does not depend on the load order.
    name = argmin(k -> (-PLOT_FUNC_PRIORITY[k], k), keys(PLOT_FUNCS))
    return PLOT_FUNCS[name](args...;kwargs...)
end

end
