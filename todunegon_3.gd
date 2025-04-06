extends Area2D

@onready var capu = get_parent().get_node("cappuccino")	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and capu.current_health <= 0 :
		get_tree().change_scene_to_file("res://dunegon_3.tscn")
