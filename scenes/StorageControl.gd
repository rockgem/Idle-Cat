extends Control

onready var list = get_node('%StorageList')


func _ready():
	ManagerGame.connect("item_storage_clicked", self, 'on_item_storage_clicked')


func refresh_list():
	for child in list.get_children():
		child.queue_free()
	
	for item in ManagerGame.player_data['inv_items']:
		var display = load("res://actors/StorageDisplay.tscn").instance()
		display.data_inside = ManagerGame.player_data['inv_items'].get(item)
		display.item_id = item
		list.add_child(display)


func on_item_storage_clicked(item_id):
	hide()


func _on_StorageControl_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		hide()


func _on_StorageControl_visibility_changed():
	if visible:
		refresh_list()
