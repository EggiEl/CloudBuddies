extends CharacterBody2D

@export var speed := 400.0 # Pixel pro Sekunde²
@export var friction := 800.0 # Für sanftes Abbremsen

func inputHandling() -> Vector2 :
	var input_direction : Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1
	return input_direction
