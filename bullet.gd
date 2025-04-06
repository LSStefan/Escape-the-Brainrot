extends Sprite2D
var lifespan = 1.7
func _physics_process(delta):
		position.x += 10
		
		
func _ready():
# Create and start a timer
	var timer = Timer.new()
	add_child(timer)  # Add the timer to the bullet
	timer.wait_time = lifespan
	timer.one_shot = true  # Timer will only run once
	timer.connect("timeout", Callable(self, "_on_timeout"))    # Connect the timeout signal
	timer.start()
	
func _on_timeout():
	queue_free() 
