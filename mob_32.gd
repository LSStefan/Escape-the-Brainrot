extends Area2D
extends Area2D # Use KinematicBody2D if you're on Godot 3.x

@export var Mihai: Node2D
@export var left_limit: float = -120.0
@export var right_limit: float = 105.0
@export var speed: float = 100.0
@onready var anim = $Spritemob

var direction := -1

func _physics_process(delta):
	position.x += speed * direction * delta

	if position.x > right_limit:
		direction = -1
		flip_sprite()

	elif position.x < left_limit:
		direction = 1
		flip_sprite()
	
	if direction !=0:
		anim.play("Walk")

func flip_sprite():
	if $Spritemob:
		$Spritemob.scale.x = -direction
		
func _on_body_entered(body):
	if body.is_in_group("player"):
		Mihai.die()
