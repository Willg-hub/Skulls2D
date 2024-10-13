extends Node

var count: int

onready var enemies_dict: Dictionary = {
	3:""
	
}

var enemies_killed: int = 0

func kill_count() -> void:
	enemies_killed += 1
	if enemies_dict.has(enemies_killed):
		var dict_value = enemies_dict[enemies_killed]
		dict_value.is_quest_finished = true
		count += 1
		
func reset() -> void:
	enemies_killed = 0
	
