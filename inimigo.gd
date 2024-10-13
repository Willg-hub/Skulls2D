extends KinematicBody2D

var player_ref = null
var velocity: Vector2
var can_die: bool = false
var can_attack: bool = false
var contador: int
var can_kill: bool = false


onready var animation: AnimationPlayer = get_node("anim")
onready var sprite: Sprite = get_node("texture")
onready var life: Label = get_node("Label")

export(int) var speed
export(int) var enemy_damage
export(int) var health
 
func _physics_process(_delta: float) -> void:
	move()
	animate()
	verify_direction()
	move()
	die()
	velocity = move_and_slide(velocity)
func move() -> void: 
	if player_ref != null:
	   var distance: Vector2 = player_ref.global_position - global_position
	   var direction: Vector2 = distance.normalized()
	   var distance_length: float = distance.length()   
	   if  distance_length <= 14  and not can_attack:
		   can_attack = true
		   velocity = Vector2.ZERO   
		   can_kill = true

	   else:
		   can_attack = false
		   velocity = speed * direction
 else:
	 velocity = Vector2.ZERO
	
	
func animate() -> void:
	if can_die:
		animation.play("dead")
		set_physics_process(false)
	elif can_attack:
		animation.play("attack")
		set_physics_process(false)
	elif velocity != Vector2.ZERO:
		 animation.play("walk")
	else:
		animation.play("idle")

func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	

func on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func on_body_exited(body):
	if body.is_in_group("player"):
	  player_ref = null
	  can_kill = false
	  set_physics_process(true)

func kill(area):
	if area.is_in_group("player_attack"):
		health -= 10
		life.text = str(int(health))

func die() -> void:
	if health <= 0:
		can_die = true
		Global.kill_count()
		
	
func on_animation_finished(anim_name):
	if anim_name == "attack" and can_kill: 
		player_ref.update_health(enemy_damage)
		set_physics_process(true)
		player_ref.kill()
	
	elif anim_name == "dead":
		 queue_free()
		 
		
	
