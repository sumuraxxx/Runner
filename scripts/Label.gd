extends Label

@onready var player = $".."

func _process(delta):
	text = str(player.position)
	
