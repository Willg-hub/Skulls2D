extends KinematicBody2D
class_name player

onready var animation: AnimationPlayer = get_node("anime")
onready var sprite: Sprite = get_node("texture")
onready var colision: CollisionShape2D = get_node("attackarea/colision")
onready var life: Label = get_node("Label")

var velocity: Vector2 
var speed = 85
var can_die: bool= false 
var can_attack: bool = false

export(int) var vida

func _physics_process(_delta: float) -> void:
	move()
	attack()
	verify_direction()
	animate()  
	
func move() -> void:
	 var direction_vector: Vector2 = Vector2(
		  Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		  Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	 velocity = direction_vector * speed
	 velocity = move_and_slide(velocity)

func attack() -> void:
	if Input.is_action_just_pressed("ui_select") and not can_attack:
		 can_attack = true

func animate() -> void:
	 if can_die:
		 animation.play("morte")
		 set_physics_process(false)
	 elif can_attack:
		  animation.play("atack")
		  set_physics_process(false)
	 elif velocity != Vector2.ZERO:
		 animation.play("run")
	 else:
		 animation.play("idle")
		
func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
		colision.position = Vector2(18, -1)
	elif velocity.x < 0:
		sprite.flip_h = true
		colision.position = Vector2(-18, -1)


func freeze(state: bool) -> void:
	animation.play("idle")
	set_physics_process(state)
	
func kill() -> void: 
	if vida <= 0:
		can_die = true
		Global.reset()
		
	
func update_health(value: int) -> void:
	vida -= value 
	life.text = str(int(vida))
	
func on_animation_finished(anim_name):
	if anim_name == "morte":
		var _reload: bool = get_tree().reload_current_scene()
	elif anim_name == "atack":
		set_physics_process(true)
		can_attack = false
		get_node("attackarea/colision").disabled = true
		
