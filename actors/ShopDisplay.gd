extends Panel

signal clicked(item_id)

export(String) var item_id





func _ready():
	$Icon.texture = load("res://assets/furniture_wall_floor_cat/objs/%s.png" % item_id)


func _on_ShopDisplay_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		emit_signal("clicked", item_id)
