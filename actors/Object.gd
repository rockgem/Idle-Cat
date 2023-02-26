extends Sprite



var is_placing: bool = false



func _ready():
	activate_placement(false)


func _unhandled_input(event):
	if event is InputEventScreenDrag:
		global_position = Vector2(stepify(event.position.x, 16), stepify(event.position.y, 8))


func activate_placement(b: bool):
	is_placing = b
	
	if b:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)
