using Gridap
domain = (0, 1, 0, 1)
partition = (2, 2)
model = CartesianDiscreteModel(domain, partition)
reffe = ReferenceFE(lagrangian, Float64, 1)
V = TestFESpace(model, reffe)
Ω = Triangulation(model)
f = interpolate(x->x[1] + x[2], V)
writevtk(Ω, "trian")
writevtk(model, "model")

using ReadVTK
readtrian = VTKFile("trian.vtu")
readmodel = VTKFile("model_2.vtu")

get_points(readmodel)
# 3×9 reshape(reinterpret(Float64, view(::Vector{UInt8}, 9:224)), 3, 9) with eltype Float64:
#  0.0  0.5  1.0  0.0  0.5  1.0  0.0  0.5  1.0
#  0.0  0.0  0.0  0.5  0.5  0.5  1.0  1.0  1.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0

get_points(readtrian)
# 3×16 reshape(reinterpret(Float64, view(::Vector{UInt8}, 9:392)), 3, 16) with eltype Float64:
#  0.0  0.5  0.0  0.5  0.5  1.0  0.5  1.0  0.0  0.5  0.0  0.5  0.5  1.0  0.5  1.0
#  0.0  0.0  0.5  0.5  0.0  0.0  0.5  0.5  0.5  0.5  1.0  1.0  0.5  0.5  1.0  1.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0

# FIXME: The triangulation VTU has duplicated points, is this intended?
