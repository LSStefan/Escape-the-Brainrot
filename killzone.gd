extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Dead!")
	if body.is_in_group("player"):
		body.die() 
