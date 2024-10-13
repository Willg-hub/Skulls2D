extends CanvasLayer
class_name interface

const DIALOG: PackedScene = preload("res://dialogo/dialogo.tscn")
const DIALOGing: PackedScene = preload("res://dialogo/dialogoingles.tscn")

func spawn_dialog(npc, dialog_text_list: Array) -> void:
	 var dialog: dialogo = DIALOG.instance()
	 dialog.dialog_text_list = dialog_text_list
	 dialog.connect("dialog_finished", npc, "on_dialog_finished")
	 add_child(dialog)
	
func spawn_dialog2(npc, dialog_text_list_ing: Array) -> void:
	 var dialoging: dialogoingles = DIALOGing.instance()
	 dialoging.dialog_text_list_ing = dialog_text_list_ing
	 dialoging.connect("dialog_finished", npc, "on_dialog_finished")
	 add_child(dialoging)
	
