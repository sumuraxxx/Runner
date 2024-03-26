extends Control

@onready var button = $Button

func _ready():
	button.connect("button_down", button_pressed)
	
	
func button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")	
