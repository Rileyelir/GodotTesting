extends StaticBody3D

var ball := preload("res://TrenchbroomTest/ball.tscn")

func _ready():
	while true:
		await get_tree().create_timer(2).timeout
		var nb = ball.instantiate()
		add_child(nb)
		nb.global_position = global_position
