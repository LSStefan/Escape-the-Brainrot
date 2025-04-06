extends Area2D
#@onready var anim_player = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#anim_player.play("cover_fade_reverse")  # 👈 Play the animation 
		#await get_tree().create_timer(1.7).timeout
		get_tree().change_scene_to_file("res://Big Boss 2.tscn")
		
