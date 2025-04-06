extends Control

func _ready():
	$CanvasLayer/VBoxContainer/BackButton.pressed.connect(on_back_pressed)

func on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
	print("Success!!")
