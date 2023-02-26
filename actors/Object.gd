extends Sprite



var is_placing: bool = false



func _ready():
	activate_placement(false)


func _unhandled_input(event):
	if event is InputEventScreenTouch and !event.pressed and is_placing == false:
		if get_rect().has_point(to_local(event.position)):
			activate_placement(true)
			ManagerGame.emit_signal("item_clicked", self)
	
	if event is InputEventScreenDrag and is_placing:
		global_position = Vector2(stepify(event.position.x, 16), stepify(event.position.y, 8))


func activate_placement(b: bool):
	is_placing = b
	
#	if b:
#		set_process_unhandled_input(true)
#	else:
#		set_process_unhandled_input(false)
