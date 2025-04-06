extends Control

func _ready():
	$CanvasLayer/VBoxContainer/StartButton.pressed.connect(on_start_pressed)
	$CanvasLayer/VBoxContainer/Credits.pressed.connect(on_options_pressed)
	$CanvasLayer/VBoxContainer/QuitButton.pressed.connect(on_quit_pressed)

func on_start_pressed():
	# Load your game scene
	get_tree().change_scene_to_file("res://intro.tscn")
	print("Success!!")
	
func on_options_pressed():
	# You can open another scene or popup
	get_tree().change_scene_to_file("res://credits_game.tscn")
	print("Credits clicked!")

func on_quit_pressed():
	get_tree().quit()
