extends Node
@onready var anim_player = $AnimationPlayer
func _ready():
	anim_player.play("text")
	

func _input(event):
	if Input.is_action_just_pressed("continue"):
		anim_player.play("Text")
		await get_tree().create_timer(1.7).timeout
		get_tree().change_scene_to_file("res://dunegon_3.tscn")
