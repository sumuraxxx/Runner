extends CharacterBody2D

signal delete_level(id_level: int)
signal spawn_level
signal death_player
signal change_point

const LEN_LEVEL = 400
const COUNT_LEVELS_IN_TIME = 4 

@export var speed = 100
@export var jump_direction = 250
@export var gravity = 500

var x_position = 0
var count_spawns = 0
var id_level = 0

@onready var animation = $AnimationPlayer

func player_movement(delta) -> void:
	var move_direction = Input.get_axis("move_left", "move_right")
	velocity.x = move_direction * speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_direction
		
	if not is_on_floor():
		velocity.y += gravity * delta	
		
	move_and_slide()	


func update_animation() -> void:
	var direction = 'idle'
	
	if velocity.x < 0:
		direction = 'run_left'
	
	if velocity.x > 0:
		direction = 'run_right'
	
	if velocity.y < 0:
		direction = 'jump'
	
	animation.play(direction)


func position_player() -> void:
	if position.x >= x_position:
		emit_signal("spawn_level")
		emit_signal("change_point")
		x_position += LEN_LEVEL
		count_spawns += 1
	if count_spawns > COUNT_LEVELS_IN_TIME:
		emit_signal("delete_level", id_level)
		count_spawns = COUNT_LEVELS_IN_TIME
		id_level += 1
	if position.y >= 450:
		emit_signal("death_player")
	
func _physics_process(delta) -> void:
	player_movement(delta)
	update_animation()
	position_player()
