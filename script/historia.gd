extends Control


func _on_next_pressed():
	if get_tree().change_scene("res://terrain/level.tscn") != OK:
		print("algo deu errado")
