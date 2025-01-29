extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

 # get every blend shape of the mesh
	var blend_shapes = get_mesh().get_blend_shape_count()
 # randomize the blend shape weights
	for i in range(blend_shapes):
		var name = get_mesh().get_blend_shape_name(i)

		self.set("blend_shapes/"+name, randf_range(-0.5, 1))
		print(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
