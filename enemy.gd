extends Node2D

const SPEED = 40
var direction = 1

@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castrightleft: RayCast2D = $RayCastrightleft
@onready var killzone: Area2D = $killzone

func _process(delta):
	if ray_castright.is_colliding():
		direction = -1
	if ray_castrightleft.is_colliding():
		direction = 1
	position.x += direction * SPEED * delta


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Check if the body is part of the "player" group
		body.die()  # Call the player's die method
	
func _on_TransitionArea_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/Big Boss 2.tscn")
