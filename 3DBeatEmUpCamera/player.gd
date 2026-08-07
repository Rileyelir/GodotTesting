extends CharacterBody3D

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized() * 5
	velocity = Vector3(direction.x, velocity.y, direction.y)
	move_and_slide()
