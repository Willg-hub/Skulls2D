extends StaticBody2D
class_name Npc

var is_quest_finished: bool = false
var can_interact: bool = false
var player_ref: KinematicBody2D = null
export(Array, String) var dialog_text_ing
export(Array, String) var dialog_text
export (Array, String) var especial_text
export (Array, String) var especial_texting

func _ready() -> void:
	Global.enemies_dict[3] = self

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_interact") and can_interact:
		can_interact = false
		player_ref.freeze(false)
		if is_quest_finished:
			get_tree().call_group("interface", "spawn_dialog", self,  especial_text)
			get_tree().call_group("interface", "spawn_dialog2", self,  especial_texting)
			player_ref.vida = 80
			player_ref.life.text = str(int(player_ref.vida))
			return
		
		get_tree().call_group("interface", "spawn_dialog", self,  dialog_text)
		get_tree().call_group("interface", "spawn_dialog2", self,  dialog_text_ing)
func on_body_entered(body) -> void:
	if body is player:
		player_ref = body
		can_interact = true


func on_body_exited(body) -> void:
	if body is player:
		player_ref = null
		can_interact = false 

func on_dialog_finished() -> void:
	 can_interact = true
	 player_ref.freeze(true)
	 
