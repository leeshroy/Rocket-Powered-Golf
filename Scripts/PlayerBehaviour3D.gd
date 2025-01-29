extends Node3D

var cam
@export var distance = 5

var viewportSize
var width
var height

#From Deepseek Ai
func get_frustum_plane_at_distance(distance: float, cam : Camera3D) -> Dictionary:
	# Convert FOV from degrees to radians
	var fov_radians = deg_to_rad(cam.fov)

	# Calculate the height of the frustum at the given distance
	var heightt = 2.0 * distance * tan(fov_radians / 2.0)

	# Calculate the width of the frustum using the aspect ratio
	var viewport_size = cam.get_viewport().get_visible_rect().size
	var aspect_ratio = viewport_size.x / viewport_size.y
	var widthh = heightt * aspect_ratio
	
	# Return the plane dimensions
	return {
		"width": widthh,
		"height": heightt,
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam = get_viewport().get_camera_3d()
	var plane = get_frustum_plane_at_distance(distance,cam)
	width = plane["width"]
	height = plane["height"]

	viewportSize = get_viewport().get_visible_rect().size

	get_viewport().connect("size_changed", updateViewportSize)

func updateViewportSize() -> void:
	viewportSize = get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousepos = get_viewport().get_mouse_position() / viewportSize
	global_position = Vector3(0,-height * mousepos.y + height * 0.5 ,width * mousepos.x - width * 0.5) + cam.global_position + -cam.transform.basis.z * distance
	
	look_at(cam.global_position)
	#global_position = cam.global_position + -cam.transform.basis.z * distance
