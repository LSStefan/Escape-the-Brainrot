extends Area2D



func _on_area_entered(area):
	if area.is_in_group("bullet"):
		print('poartaincasa')
		var gate_tilemap = get_parent().get_node("poarta")
		for i in range(158,166):
			gate_tilemap.erase_cell(0, Vector2i(i, 75))  # change to your gate tile position
		queue_free()  # remove the button after use (optional)
