extends "res://Characters/CompostionScripts/BasicPlayerMovement.gd"

func _physics_process(_delta: float) -> void:
	var input_direction : Vector2 = inputHandling()
	velocity = input_direction.normalized() * speed
	move_and_slide()
