extends Node

@onready var capu = get_node("cappuccino")	
# Replace "intro" with the name of your animationextends Node2D
func _process(delta):
	if capu.is_alive == 0:
		get_tree().change_scene_to_file("res://second_boss_kill.tscn")
