# PlotlyExtensionsHelper

[![Build Status](https://github.com/disberd/PlotlyExtensionsHelper.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/disberd/PlotlyExtensionsHelper.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

The primary objective of this package is to enable package authors to integrate plotting functionality within their packages through extensions that support multiple plotting libraries with a single extension. This package is designed to be compatible with plotting libraries based on [PlotlyBase.jl](https://github.com/sglyon/PlotlyBase.jl), such as PlotlyBase, PlotlyJS, and PlutoPlotly.

Other packages based on Plotly can add their own backend, see [Adding a backend](#adding-a-backend).

The principal way of using this package is to have `PlotlyExtensionsHelper` as dependency of the target package, and then provide a single extensions with PlotlyBase.jl as trigger.
The extension should implement the specific plotting functionality and generate its output (the plot) using `PlotlyExtensionsHelper.plotly_plot` rather than using `PlotlyBase.Plot`. 

`PlotlyExtensionsHelper.plotly_plot` forwards all its positional and keyword arguments to the plotting function of the loaded backend with the highest priority.
If two backends have the same priority, `plotly_plot` uses the backend with the name that sorts first.

The default priorities are:

| Backend | Priority |
|---|---|
| PlutoPlotly | 20 |
| PlotlyJS | 10 |
| PlotlyBase | 0 |

To change a priority for all sessions, set the `plot_func_priority` preference.
The value replaces the default priority of the backend when Julia loads the package again:

```julia
using Preferences, PlotlyExtensionsHelper
set_preferences!(PlotlyExtensionsHelper, "plot_func_priority" => Dict("PlotlyJS" => 30))
```

This writes the preference to the `LocalPreferences.toml` file of the active project:

```toml
[PlotlyExtensionsHelper.plot_func_priority]
PlotlyJS = 30
```

To change a priority for the current session only, change the value in the `PLOT_FUNC_PRIORITY` dictionary:

```julia
PlotlyExtensionsHelper.PLOT_FUNC_PRIORITY[:PlotlyJS] = 30
```

You can find a more clarifying example on how to implement plotting in a package using `PlotlyExtensionsHelper` in the test folder within its [ExampleEnvironment](test/ExampleEnvironment/) subfolder.
The example package providing some plotting functionality is within the [ExamplePackage](test/ExampleEnvironment/ExamplePackage) folder, while example of its use with _seamelss_ plotting package switching can be checked by either including the [`test_include.jl`](test/ExampleEnvironment/test_include.jl) file in the REPL, or by opening the [`test_notebook.jl`](test/ExampleEnvironment/test_notebook.jl) within Pluto

The first file will use PlotlyJS to show the plot, while the second example (the notebook) will use PlutoPlotly to show the plot.

## Adding a backend

A package adds a backend with `PlotlyExtensionsHelper.register_plot_func!(name, f; priority)`.
A higher `priority` gives a higher default priority.
Put the call in an extension of your package that `PlotlyExtensionsHelper` triggers:

```julia
module MyBackendPlotlyExtensionsHelperExt
    import MyBackend, PlotlyExtensionsHelper
    __init__() = PlotlyExtensionsHelper.register_plot_func!(:MyBackend, MyBackend.plot; priority = 15)
end
```

Do not call `register_plot_func!` at the top level of a module. The precompilation cache does not keep the registration. Call it from `__init__`.

A priority that the user sets before the registration stays. This includes the `plot_func_priority` preference.