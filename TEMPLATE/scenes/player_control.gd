extends CharacterBody3D


const SPEED = 12.0
const JUMP_VELOCITY = 8.0
var MOUSE_SENS = 0.25
var DASH_VELOCITY = 8.0
var is_dashing = false
var can_dash = true

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# TIMER FUNCTIONS
func _on_dash_timer_timeout():
	print("dash timer timeout")
	velocity = Vector3.ZERO
	is_dashing = false
	can_dash = true





func _input(event):
	if event is InputEventMouseMotion:
	

		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		$Head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
		$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func walking(direction):
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func dash(direction):
	
	if direction:
		velocity.x = direction.x * SPEED * DASH_VELOCITY
		velocity.z = direction.z * SPEED * DASH_VELOCITY
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 20)
		velocity.z = move_toward(velocity.z, 0, SPEED * 20)



func _physics_process(delta: float) -> void:
	
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	

	
	
	
	
	
	
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY




	if Input.is_action_just_pressed("dash") and !is_dashing  and can_dash:
		#create a timer
		can_dash = false
		var dash_timer = Timer.new()
		#add the timer to the scene
		add_child(dash_timer)
		#set the timer to 0.5 seconds and oneshot
		dash_timer.set_wait_time(0.1)
		dash_timer.set_one_shot(true)
		#connect the timeout signal to the function
		dash_timer.connect("timeout", Callable(self, "_on_dash_timer_timeout"))
		dash_timer.start()
		is_dashing = true
		dash(direction)
	else:
		if !is_dashing:
			walking(direction)

	move_and_slide()
