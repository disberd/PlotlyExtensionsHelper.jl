# Changelog

This file contains the changelog for the PlotlyExtensionsHelper package. It follows the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.

## Unreleased

## [0.3.0]

### Added

- `register_plot_func!(name, f; priority)` lets other packages add a plotting backend with a default priority from the `__init__` of their extension, without type piracy.
- `PLOT_FUNC_PRIORITY` is a `Dict` of integer priorities. `plotly_plot` uses the loaded backend with the highest priority. For equal priorities, it uses the name that sorts first.
- The `plot_func_priority` preference changes the priority of a backend for all sessions.
- Mark `register_plot_func!`, `PLOT_FUNC_PRIORITY`, `sample_colorscheme` and `discrete_colorscale` as `public`.

### Changed

- The minimum supported Julia version is 1.12.
- Preferences is a dependency.
- The extensions of this package register their backends with the default priorities PlutoPlotly 20, PlotlyJS 10, and PlotlyBase 0.
- `PLOT_FUNC_PRIORITY` is no longer an ordered `Vector{Symbol}`. Change the integer priority of a backend instead of the position in a vector.

### Removed

- The internal `_plot_func(::Val{name})` hook. Use `register_plot_func!` to add a backend, and `Base.get_extension` to check if Julia loaded an extension.

## [0.2.2] - 2025-03-23

### Changed

- Add compat for PlutoPlotly 0.6.

## [0.2.1] - 2025-03-18

### Added

- Added `sample_colorscheme` and `discrete_colorscale` functions to the `PlotlyExtensionsHelper` module (though unexported) to provide utilities for colorschemes to be used in plotly extensions.

