extends CharacterBody2D

@export var speed := 350       # Running speed
@export var jump_force := -500 # Jump strength
@export var gravity := 1000     # Gravity force
@export var friction := 2000    # How fast the character stops
@export var max_fall_speed := 500  # Limit falling speed
@export var bullet : PackedScene 
var last_shot_time = 0.0  
var direction := Vector2(1, 0) 
var b
@onready var anim = $AnimatedSprite2D  # Reference to sprite
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

	last_shot_time += delta
	# Move player
	move_and_slide()
	if Input.is_action_just_pressed("shoot"):  # Replace "shoot" with your input action
		shoot()
		
var shoot_cooldown = 0.5 
func shoot():
	print("culcat")
	if bullet and (last_shot_time >= shoot_cooldown):
		b = bullet.instantiate()
		b.position = position + Vector2(10, -20) 
		get_parent().add_child(b)
		last_shot_time = 0.0 
		
func die():
	
	velocity = Vector2.ZERO
	set_physics_process(false)

	# Disable collision
	$CollisionShape2D.disabled = true
	
	anim.play("die")
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
