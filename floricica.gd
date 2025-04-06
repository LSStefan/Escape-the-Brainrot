extends Area2D

# your existing variables...
@export var dash_speed := 1000.0
@export var min_speed := 100.0
@export var deceleration := 400.0
@export var left_limit := -599
@export var right_limit := 500

@onready var health_bar := get_tree().get_root().get_node("Bossfight1/HealthBar")
@onready var sprite := $Sprite2D
@onready var flash_timer = $DamageFlashTimer
var is_alive = 1
var speed := 0.0
var direction := 1

@export var max_health := 100
var current_health := max_health

func _ready():
	connect("body_entered", Callable(self, "_on_boss_body_entered"))
	await get_tree().create_timer(9.0).timeout  # wait 2 seconds
	speed = dash_speed

func _process(delta):
	if is_alive == 1:
		position.x += direction * speed * delta
		$Sprite2D.rotation += direction * deg_to_rad(speed * delta)
		if speed > min_speed:
			speed -= deceleration * delta
			speed = max(speed, min_speed)

	

func take_damage(amount):
	current_health -= amount
	health_bar.value = current_health
	
	# Flash red
	sprite.modulate = Color(1, 0, 0)
	flash_timer.start()

func die():
	print("ai belit pula")
	speed = 0.0
	direction = 0
	await get_tree().create_timer(2.0).timeout
	$Sprite2D.queue_free()
	await get_tree().create_timer(5.0).timeout
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()  # we'll add this function to the player
	if body.is_in_group("perete"):
		take_damage(10)
		if current_health <= 0 :
			is_alive = 0;
			die()
	if direction == -1:
		direction = 1
		speed = dash_speed
	elif direction == 1:
		direction = -1
		speed = dash_speed
	


func _on_damage_flash_timer_timeout():
	if is_alive == 1:
		sprite.modulate = Color(1,1,1)
