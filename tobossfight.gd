extends Area2D

@export var anim : AnimationPlayer

func _on_body_entered(body):
	if body.is_in_group("player"):
		anim.play("trans")
		await get_tree().create_timer(1.7).timeout
		get_tree().change_scene_to_file("res://bossfight_3.tscn")
		
