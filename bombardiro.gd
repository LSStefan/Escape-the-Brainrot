extends Area2D

@export var speed := 300.0  # Movement speed of the crocodile
@export var bomb_scene: PackedScene  # Assign your Bomb.tscn here in the Inspector
var direction := Vector2(1, 0)  # Start moving to the right
@onready var video = $VideoStreamPlayer
@export var max_health := 100
var current_health := max_health
@onready var health_bar := get_tree().get_root().get_node("bossfight3/HealthBar")
@onready var sprite := $Sprite2D  # Get the sprite node for color manipulation
var fin = 0
func _ready():
	# Move the crocodile across the screen
	$bombtimer.wait_time = 1.0 # Start the timer when the boss is ready
	
	flip_boss()
	if health_bar:  # Ensure health_bar is assigned
		health_bar.max_value = max_health  # Set the max value for the health bar
		health_bar.value = current_health  # Initialize health bar with current health
func _on_video_stream_player_finished():
	fin = 1
func _process(delta):
	if fin:
		$bombtimer.start()
		fin = 0
	position.x += direction.x * speed * delta

	# Change direction when hitting the screen edges
	if position.x > get_viewport().size.x or position.x < 0:
		direction.x *= -1  # Reverse direction
		flip_boss()  # Call function to flip the boss
		position.y = randf_range(50, 400)  # Randomize Y position slightly after hitting an edge

func drop_bomb():
	if bomb_scene:
		var bomb = bomb_scene.instantiate()  # Create a bomb instance
		bomb.position = position + Vector2(0, 50)  # Set the bomb drop position slightly below the crocodile
		get_tree().current_scene.add_child(bomb)  # Add the bomb to the current scene

func _on_bombtimer_timeout():
	drop_bomb()  # Call the drop bomb function

func flip_boss():
	# Flip the boss sprite horizontally
	sprite.scale.x *= -1  # Invert the x scale to flip the sprite

func take_damage():
	current_health -= 10
	if health_bar:  # Ensure health_bar is not null
		health_bar.value = current_health  # Update health bar value
	
	# Change color to red to indicate hit
	sprite.modulate = Color(1, 0, 0)  # Set color to red
	await get_tree().create_timer(0.2).timeout  # Wait for 0.2 seconds
	sprite.modulate = Color(1, 1, 1)  # Reset color to white
	
	if current_health <= 0:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		take_damage()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()  # Handle player collision logic
