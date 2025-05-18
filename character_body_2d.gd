extends CharacterBody2D

@export var max_speed := 600.0
@export var acceleration := 400.0 # Pixel pro Sekunde²
@export var friction := 800.0 # Für sanftes Abbremsen

var dragging := false
var drag_start := Vector2.ZERO
var drag_end := Vector2.ZERO
func _input(event : InputEvent): -> void 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var query = PhysicsPointQueryParameters2D.new() 
			query.position = get_global_mouse_position()
			query.collide_with_bodies = true
			query.collide_with_areas = false
			query.exclude = []

			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_point(query)

			for hit in result:
				if hit.collider == self:
					dragging = true
					drag_start = get_global_mouse_position()
					break
		else:
			if dragging:
				dragging = false
				drag_end = get_global_mouse_position()
				var drag_vector = drag_start - drag_end
				velocity += drag_vector * 8
				if velocity.length() > max_speed:
					velocity = velocity.normalized() * max_speed

func _physics_process(delta):
	var input_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1

	if input_direction != Vector2.ZERO and not dragging:
		input_direction = input_direction.normalized()
		velocity += input_direction *  acceleration * delta
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
		
	else:
		if not dragging:
			var speed = velocity.length()
			if speed > 0:
				var decel = friction * delta
				speed = max(speed - decel, 0)
				velocity = velocity.normalized() * speed
	if position[0] > 800: 
					velocity = -velocity  
	
	move_and_slide()
