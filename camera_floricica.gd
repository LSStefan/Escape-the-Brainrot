extends Camera2D

func _ready():
	make_current()  # Ensure this camera is the active one

@export var new_camera: Camera2D
