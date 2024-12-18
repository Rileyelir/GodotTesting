extends Control

func _ready():

	for button in $Panel/ScrollContainer/VBoxContainer.get_children():

		if button.text == "N/A": button.disabled = true

func _on_animatronic_movement_pressed():

	get_tree().change_scene_to_file("res://AnimatronicMovement/animatronic_movement.tscn")

func _on_animation_player_test_pressed():
	
	get_tree().change_scene_to_file("res://AnimationPlayerTest/animation_player_test.tscn")

func _on_fighting_game_collision_box_test_pressed():
	
	get_tree().change_scene_to_file("res://FightingGameCollisionBoxTest/fighting_game_collision_box_test.tscn")

func _on_network_test_pressed():

	get_tree().change_scene_to_file("res://NetworkTest/network_test.tscn")

func _on_shader_test_pressed():
	
	get_tree().change_scene_to_file("res://ShaderTest/shader_test.tscn")