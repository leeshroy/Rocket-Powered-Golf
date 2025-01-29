extends CharacterBody3D

@export var speed = 5
@export var distanceFromCamera : float = 5

var target : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_viewport().get_camera_3d()
	look_at(target.global_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movementVector = (target.global_position - global_position).normalized() * delta * speed
	var colllisionInfo = move_and_collide(movementVector)


	if colllisionInfo && colllisionInfo.get_collider().is_in_group("Player"):
		print("ABGFEFANGE")
		free()
		return

	var distFromTarget = (global_position - target.position).length()
	if distFromTarget < distanceFromCamera:
		print("Reached Player")
		free()
		
	
		
