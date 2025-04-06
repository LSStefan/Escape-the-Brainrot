extends Node

@onready var croco = get_node("bombardiro")	
# Replace "intro" with the name of your animationextends Node2D
func _process(delta):
	if croco.current_health <= 0:
		get_tree().change_scene_to_file("res://node.tscn")
