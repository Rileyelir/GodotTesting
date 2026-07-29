extends CharacterBody2D

var speed := 200.0

func _network_spawn(data: Dictionary) -> void:
	set_multiplayer_authority(data.owner_peer_id)

func _get_local_input() -> Dictionary:
	var input := {}
	if multiplayer.get_unique_id() == get_multiplayer_authority():
		input.move = Input.get_vector("left", "right", "up", "down")
	return input

func _network_process(input: Dictionary) -> void:
	velocity = input.get("move", Vector2.ZERO) * speed
	move_and_slide()

func _save_state() -> Dictionary:
	return {
		position_x = position.x,
		position_y = position.y,
		velocity = velocity,
	}

func _load_state(state: Dictionary) -> void:
	position = Vector2(state.position_x, state.position_y)
	velocity = state.velocity
	
	PhysicsServer2D.body_set_state(
		get_rid(),PhysicsServer2D.BODY_STATE_TRANSFORM, global_transform
	)
