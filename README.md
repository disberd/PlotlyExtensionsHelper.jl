# PlotlyExtensionsHelper

[![Build Status](https://github.com/disberd/PlotlyExtensionsHelper.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/disberd/PlotlyExtensionsHelper.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

The primary objective of this package is to enable package authors to integrate plotting functionality within their packages through extensions that support multiple plotting libraries with a single extension. This package is designed to be compatible with plotting libraries based on [PlotlyBase.jl](https://github.com/sglyon/PlotlyBase.jl), such as PlotlyBase, PlotlyJS, and PlutoPlotly.

Support for other plotly-based packages might be considered in the future.

The principal way of using this package is to have `PlotlyExtensionsHelper` as dependency of the target package, and then provide a single extensions with PlotlyBase.jl as trigger.
The extension should implement the specific plotting functionality and generate its output (the plot) using `PlotlyExtensionsHelper.plotly_plot` rather than using `PlotlyBase.Plot`. 

`PlotlyExtensionsHelper.plotly_plot` will simply forward all argument and keyword arguments provided to it to the relevant function on the 3 supported packages depending on what is loaded and on the priority specified in `PlotlyExtensionsHelper.PLOT_FUNC_PRIORITY`

The default priority is in this order:
- PlutoPlotly (highest priority)
- PlotlyJS
- PlotlyBase (lowest priority)

You can find a more clarifying example on how to implement plotting in a package using `PlotlyExtensionsHelper` in the test folder within its [ExampleEnvironment](test/ExampleEnvironment/) subfolder.
The example package providing some plotting functionality is within the [ExamplePackage](test/ExampleEnvironment/ExamplePackage) folder, while example of its use with _seamelss_ plotting package switching can be checked by either including the [`test_include.jl`](test/ExampleEnvironment/test_include.jl) file in the REPL, or by opening the [`test_notebook.jl`](test/ExampleEnvironment/test_notebook.jl) within Pluto

The first file will use PlotlyJS to show the plot, while the second example (the notebook) will use PlutoPlotly to show the plot.