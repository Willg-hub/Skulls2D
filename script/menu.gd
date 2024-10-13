extends Control

func _on_start_pressed():
	if get_tree().change_scene("res://terrain/historia.tscn") != OK:
		print("algo deu errado")


func _on_quit_pressed():
	get_tree().quit()


func _on_link_pressed():
	var _open_chanel: bool = OS.shell_open("http://fmpsc.edu.br/course/ads/")
