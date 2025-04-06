extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var scene : PackedScene
@onready var floricica = get_node("Floricica")	
func _ready():
	await get_tree().create_timer(7.0).timeout
	anim_player.play("cover_fade") # Replace "intro" with the name of your animationextends Node2D
func _process(delta):
	if floricica.is_alive == 0:
		await get_tree().create_timer(2.0).timeout
		anim_player.play("cover_fade_reverese")
		#await anim_player.animation_finished  
		await get_tree().create_timer(1.7).timeout
		get_tree().change_scene_to_file("res://first_boss_killed.tscn")
