extends Sprite


# this is used to prevent clicking other objs while moving this object
var is_selected: bool = false


func _ready():
	activate_placement(false)


func _unhandled_input(event):
	if event is InputEventScreenTouch and !event.pressed and ManagerGame.is_placing == false and is_selected == false:
		if get_rect().has_point(to_local(event.position)):
			activate_placement(true)
			ManagerGame.emit_signal("item_clicked", self)
	
	if event is InputEventScreenDrag and ManagerGame.is_placing and is_selected:
		global_position = Vector2(stepify(event.position.x, 16), stepify(event.position.y, 8))


func activate_placement(b: bool):
	ManagerGame.is_placing = b
	is_selected = b
