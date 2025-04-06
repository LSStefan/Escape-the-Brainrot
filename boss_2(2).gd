extends Area2D

@export var custom_gravity: float = 1200.0  # Gravity force applied
@export var jump_speed: float = 1000.0  # Increased jump speed for higher jumps
@export var bounce_angle: float = 45.0  # Angle for jumping (lower for more forward movement)
@export var bounce_interval: float = 1.5  # Time interval to jump again
var is_alive = 1
var bounce_timer: float = 0.0
var is_jumping: bool = false
var velocity: Vector2 = Vector2.ZERO  # Initialize velocity

@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castrightleft: RayCast2D = $RayCastrightleft
@onready var ray_castup: RayCast2D = $RayCastup
@onready var ray_castdown: RayCast2D = $RayCastdown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health := 100
var current_health := max_health
@onready var health_bar := get_tree().get_root().get_node("BigBoss 2/HealthBar")
var direction = 1  # 1 for right, -1 for left

func _ready():
	bounce_timer = bounce_interval
	ray_castrightleft.enabled = true
	ray_castright.enabled = true
	ray_castup.enabled = true
	ray_castdown.enabled = true

func _process(delta):
	pass

func _physics_process(delta):
	# Apply gravity
	velocity.y += custom_gravity * delta * 3
	velocity.x = direction * 100  # Horizontal movement

	# Timer for jumps
	bounce_timer -= delta
	if bounce_timer <= 0.0 and is_on_floor() and !is_jumping:
		start_jump()

	# Actual jump
	if is_jumping:
		# Calculate upward and forward velocity
		velocity.x = jump_speed * 0.5 * direction  # Less forward speed for kangaroo-like jump
		velocity.y = -jump_speed * 1.5  # Strong upward velocity

	# Collision with the ceiling
	if ray_castup.is_colliding():
		velocity.y = abs(velocity.y)  # Bounce off the ceiling
		bounce_timer = bounce_interval

	# Collision with the ground
	if ray_castdown.is_colliding():
		velocity.y = -abs(velocity.y)  # Bounce off the ground
		bounce_timer = bounce_interval
		is_jumping = false  # Reset jumping state

	# Collision with walls
	if ray_castrightleft.is_colliding():
		direction = -direction  # Change direction when hitting walls
		bounce_timer = bounce_interval

	if ray_castright.is_colliding():
		direction = -1
		bounce_timer = bounce_interval

	# Move the boss character
	position += velocity * delta  # Manual movement for Area2D

func start_jump():
	is_jumping = true
	bounce_timer = bounce_interval

func is_on_floor() -> bool:
	# Check if the raycast down is colliding
	return ray_castdown.is_colliding()

func take_damage():
	current_health -= 10
	print("DAMAGE!")
	if health_bar:
		health_bar.value = current_health
	animated_sprite_2d.modulate = Color(1, 0, 0)  # Change color to red
	await get_tree().create_timer(0.2).timeout  # Wait for 0.2 seconds
	animated_sprite_2d.modulate = Color(1, 1, 1)  # Reset color to white

	if current_health <= 0:
		is_alive = 0;
		$AnimatedSprite2D.queue_free()  # Remove the boss if health is zero
		await get_tree().create_timer(10.0).timeout  # Wait for 0.2 seconds
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		take_damage()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()  # Handle player collision logic
