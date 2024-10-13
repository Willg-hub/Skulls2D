extends TouchScreenButton


func _on_creditos_pressed():
	if get_tree().change_scene("res://terrain/creditos.tscn") != OK:
		print("algo deu errado")
