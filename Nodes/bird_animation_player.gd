extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf() > 0.5:
		play("FLY")
	else:
		play("IDLE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
