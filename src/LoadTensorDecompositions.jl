module LoadTensorDecompositions

import FileIO
import JLD
import JLD2

JLD.translate("Core.Bool", "bool")

if isdefined(Main, :TensorDecompositions)
	@warn("TensorDecompositions is imported in the REPL; LoadTensorDecompositions may not work!")
end

function loadtucker(f::String, arg...; kw...)
	if isfile(f)
		if isdefined(Main, :TensorDecompositions)
			@warn("TensorDecompositions is imported in the REPL; LoadTensorDecompositions may not work!")
		end
		d = FileIO.load(f, arg...; kw...)
		if typeof(d) <: AbstractVector
			dc = Vector{Any}(undef, 0)
			df = Vector{Any}(undef, 0)
			dp = Vector{Any}(undef, 0)
			n = length(d)
			for i = 1:n
				push!(dc, d[i].core)
				push!(df, d[i].factors)
				push!(dp, d[i].props)
			end
			return dc, df, dp
		else
			return d.core, d.factors, d.props
		end
	end
end

end