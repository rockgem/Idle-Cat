extends Control

onready var list = get_node('%StorageList')


func refresh_list():
	for child in list.get_children():
		child.queue_free()
	
	for item in ManagerGame.player_data['inv_items']:
		var display = load("res://actors/StorageDisplay.tscn").instance()
		display.data_inside = ManagerGame.player_data['inv_items'].get(item)
		display.item_id = item
		list.add_child(display)


func _on_StorageControl_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		hide()


func _on_StorageControl_visibility_changed():
	if visible:
		refresh_list()
