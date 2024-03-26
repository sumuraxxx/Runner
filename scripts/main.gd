extends Node2D

@export var level_sceen_array: Array[PackedScene]
@export var count_points = 5
	
var x_position = 0
var levels_array: Array[Node2D]
var points = -5

@onready var player = $Player
@onready var text_points = $CanvasLayer/Control/Label

func _ready() -> void:
	signal_connect()
	spawn_level_scene()
	

func signal_connect() -> void:
	player.connect("spawn_level", spawn_level_scene)
	player.connect("delete_level", delete_level_scene)
	player.connect("death_player", death_player)
	player.connect("change_point", change_point)
	
		
func spawn_level_scene() -> void:
	var id_scene = randi_range(0, len(level_sceen_array) - 1)
	var level_scene = level_sceen_array[id_scene].instantiate()
	level_scene.position = Vector2(x_position, 220)
	x_position += 400
	levels_array.append(level_scene)
	add_child(level_scene)
	

func delete_level_scene(id) -> void:
	var level_sceen = levels_array[id] 
	level_sceen.queue_free()
	

func death_player() -> void:
	get_tree().change_scene_to_file("res://scenes/main/death_scene.tscn")
	player.queue_free()
	

func change_point() -> void:
	points += count_points
	text_points.text = str(points)
	
