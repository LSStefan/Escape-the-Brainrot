extends Area2D

@export var new_camera: Camera2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		if new_camera:
			new_camera.make_current()
			
