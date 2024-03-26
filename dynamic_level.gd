class_name MovingPlatform
extends Node2D

@export var platform: TileMap
@export var start_pos: Marker2D
@export var end_pos: Marker2D
@export_range(-1, 1) var direction: int = 1

var time := 5.0
var temp_time := time

func _ready() -> void:
	platform.global_position = start_pos.global_position


func change_direction() -> void:
	var temp = end_pos
	end_pos = start_pos
	start_pos = temp
	direction = direction * -1  


func platform_movement(delta) -> void:
	var distance = platform.global_position.distance_to(end_pos.global_position)

	if distance > 1:
		platform.global_position.x += direction
	else:
		platform.global_position = end_pos.global_position
		timer(delta)
	

func timer(delta) -> void:
	temp_time -= delta
	if temp_time <= 0:
		temp_time = time
		change_direction()

		
func _physics_process(delta) -> void:
	platform_movement(delta)
	
