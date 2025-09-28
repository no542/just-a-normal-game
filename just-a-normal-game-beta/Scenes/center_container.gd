extends CenterContainer

func _on_quitbutton_pressed() -> void:
	get_tree().quit()

func _on_playbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
