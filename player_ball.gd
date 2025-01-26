extends CharacterBody2D


@export var speed = 300.0
var mouse_position = null

func _physics_process(delta: float) -> void:
	mouse_position = get_global_mouse_position()
	
	if Input.is_action_pressed("forward"):
		var direction = (mouse_position - position).normalized()
		velocity = (direction * speed)
	
	move_and_slide()
	look_at(mouse_position)
