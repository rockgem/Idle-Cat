extends Panel



var data_inside = {}
var item_id


func _ready():
	$Icon.texture = load("res://assets/furniture_wall_floor_cat/objs/%s.png" % item_id)
	
	if data_inside['stack'] > 1:
		$Amount.text = 'x' + str(data_inside['stack'])
		$Amount.show()
	else:
		$Amount.hide()


func _on_StorageDisplay_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		data_inside['stack'] -= 1
		ManagerGame.emit_signal("item_storage_clicked", item_id)
