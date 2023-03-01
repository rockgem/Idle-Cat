extends Control

var ref = null

func _ready():
	ManagerGame.connect("item_clicked", self, 'on_item_clicked')
	ManagerGame.connect("item_storage_clicked", self, 'on_item_storage_clicked')


func on_item_clicked(own):
	
	ref = own
	
	
	$Layer1.hide()
	$PlacementControls.show()


func on_item_storage_clicked(item_id):
	$Layer1.hide()
	$PlacementControls.show()


func _on_Place_pressed():
	if ref:
		ref.activate_placement(false)
	$Layer1.show()
	$PlacementControls.hide()
	
	ref = null


func _on_Left_pressed():
	ref.flip_h = !ref.flip_h


func _on_Buy_pressed():
	get_node('%Shop').show()


func _on_Storage_pressed():
	$StorageControl.show()


func _on_ToStorage_pressed():
	ManagerGame.add_item_to_storage(ref.item_id)
	$Layer1.show()
	$PlacementControls.hide()
	ref.queue_free()
