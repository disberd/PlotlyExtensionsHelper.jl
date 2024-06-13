### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 46a88cc0-296d-11ef-2cbb-134d9853f781
begin
	import Pkg
	Pkg.activate(@__DIR__)
end

# ╔═╡ 42dfa255-0880-44cd-a4cc-c9af03f47255
begin
	using ExamplePackage
	using PlutoPlotly
end

# ╔═╡ 4e134046-ff35-417f-864f-96ceb93c22e9
# This will be plotted with PlutoPlotly as it's the highest priority
plot_4_lines()

# ╔═╡ Cell order:
# ╠═46a88cc0-296d-11ef-2cbb-134d9853f781
# ╠═42dfa255-0880-44cd-a4cc-c9af03f47255
# ╠═4e134046-ff35-417f-864f-96ceb93c22e9
