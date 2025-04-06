extends Area2D

var velocity = Vector2()

@onready var sprite = $Sprite  # Reference to the sprite node (make sure it's in the bullet scene)
@onready var collision_shape = $CollisionShape2D  # Reference to the collision shape

func _ready():
	# Make sure the bullet's collision shape is enabled and set up
	collision_shape.disabled = false

func _process(delta):
	position += velocity * delta  # Move the projectile

# When the bullet enters a collision area
func _on_body_entered(body):
	# Destroy the bullet if it collides with anything
	if !body.is_in_group("player"):
		print("loalsoflsd")
		get_parent().queue_free()
