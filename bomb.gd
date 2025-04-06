extends Area2D  # or Area2D if you prefer

@export var fall_speed := 500.0  # Speed at which the bomb falls
@export var explosion_radius := 100.0  # Radius of the explosion effect
@export var damage := 20  # Damage caused by the bomb
@onready var anim = $AnimatedSprite2D  # Reference to sprite

func _ready():
	await get_tree().create_timer(20.0).timeout
func _process(delta):
	# Move the bomb downwards
	position.y += fall_speed * delta

	# Check if the bomb has fallen below the screen
	if position.y > get_viewport().size.y:
		queue_free()  # Remove the bomb from the scene

func _on_Bomb_body_entered(body):
	if body.is_in_group("player"):  
		body.die()  # Call a function to handle player damage
		queue_free()  # Remove the bomb after hitting the player
	if body.is_in_group("floor"):
		anim.play("explosion")
		
