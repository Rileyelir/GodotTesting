extends Node3D

# exports, assign these in editor!!
@export var player1: CharacterBody3D
@export var player2: CharacterBody3D
@export var camera: Camera3D

const CAMERA_INTERP_SPEED: float = 0.03 # how fast the camera interpolates its movement (0.0 to 1.0 because lerp)
const CAMERA_DISTANCE_CLAMPS: Array[float] = [7.0, 20.0] # Idx. 0 is clamp for being close, idx. 1 is clamp for being far
const DISTANCE_MULTIPLIER: float = 1.2 # controls how sensitive the zoom is based on the distance of the players

func _process(_delta):
	# get midpoint and look at it
	var midpoint: Vector3 = (player1.global_position + player2.global_position) / 2
	camera.look_at(midpoint)
	
	# lerp side-to-side with midpoint's x
	camera.global_position.x = lerp(
		camera.global_position.x,
		midpoint.x,
		CAMERA_INTERP_SPEED
	)
	
	# adjust distance of camera from players
	var distance = player1.global_position.distance_to(player2.global_position)
	camera.global_position.z = lerp(camera.global_position.z, clampf(distance * 1.2, CAMERA_DISTANCE_CLAMPS[0], CAMERA_DISTANCE_CLAMPS[1]), CAMERA_INTERP_SPEED)
