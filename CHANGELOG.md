# Changelog

This file contains the changelog for the PlotlyExtensionsHelper package. It follows the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.

## Unreleased

## [0.3.0] - 2026-09-24

This release is breaking. [PR #8](https://github.com/disberd/PlotlyExtensionsHelper.jl/pull/8) explains the motivation and lists the breaking changes.

### Breaking

- The minimum supported Julia version is 1.12.
- `PLOT_FUNC_PRIORITY` is a `Dict{Symbol, Int}` of integer priorities, and no longer an ordered `Vector{Symbol}`. To change the priority of a backend, set its integer priority.
- This release removes the internal `_plot_func(::Val{name})` hook. To add a backend, use `register_plot_func!`. To check if Julia loaded an extension, use `Base.get_extension`.
- Preferences is a new dependency.

### Added

- `register_plot_func!(name, f; priority)` lets other packages add a plotting backend with a default priority from the `__init__` of their extension, without type piracy.
- `plotly_plot` uses the loaded backend with the highest priority. For equal priorities, it uses the name that sorts first.
- The `plot_func_priority` preference changes the priority of a backend for all sessions.
- Mark `register_plot_func!`, `PLOT_FUNC_PRIORITY`, `sample_colorscheme` and `discrete_colorscale` as `public`.

### Changed

- The extensions of this package register their backends with the default priorities PlutoPlotly 20, PlotlyJS 10, and PlotlyBase 0.

## [0.2.2] - 2025-03-23

### Changed

- Add compat for PlutoPlotly 0.6.

## [0.2.1] - 2025-03-18

### Added

- Added `sample_colorscheme` and `discrete_colorscale` functions to the `PlotlyExtensionsHelper` module (though unexported) to provide utilities for colorschemes to be used in plotly extensions.

