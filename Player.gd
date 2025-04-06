extends CharacterBody2D

@export var speed := 350       # Running speed
@export var jump_force := -500 # Jump strength
@export var gravity := 1000     # Gravity force
@export var friction := 2000    # How fast the character stops
@export var max_fall_speed := 500  # Limit falling speed

@onready var anim = $AnimatedSprite2D  # Reference to sprite
@onready var s = $CharacterBody2D  # Reference to sprite
var flip_offset := 16  # Adjust based on your sprite's width or visual offset

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)  # Limit fall speed

	# Get horizontal movement input
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction > 0:
		velocity.x = direction * speed # Move
		anim.flip_h = direction  < 0 # Flip sprite
		$CollisionShape2D.position.x = $AnimatedSprite2D.position.x - 25
		anim.position.x = -flip_offset if anim.flip_h else flip_offset
	if direction < 0:
		velocity.x = direction * speed # Move
		anim.flip_h = direction  < 0 # Flip sprite
		$CollisionShape2D.position.x = $AnimatedSprite2D.position.x + 20
		anim.position.x = -flip_offset if anim.flip_h else flip_offset
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)  # Stop smoothly

	# Jumping
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force  # Jump force

	# Animations
	if not is_on_floor():
		anim.play("jump" if velocity.y < 0 else "fall")  # Play jump/fall
	elif direction != 0:
		anim.play("run")  # Running animation
	else:
		anim.play("idle")  # Idle animation
	# Move player
	move_and_slide()
	
func die():
	queue_free()
	get_tree().reload_current_scene()
	
	
