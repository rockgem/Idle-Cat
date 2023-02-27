extends Control

var ref = null

func _ready():
	ManagerGame.connect("item_clicked", self, 'on_item_clicked')


func on_item_clicked(own):
	if ref == null:
		ref = own
	else:
		return
	
	$Layer1.hide()
	$PlacementControls.show()


func _on_Place_pressed():
	ref.activate_placement(false)
	$Layer1.show()
	$PlacementControls.hide()
	
	ref = null


func _on_Left_pressed():
	ref.flip_h = !ref.flip_h


func _on_Buy_pressed():
	get_node('%Shop').show()


func _on_CloseShop_pressed():
	get_node('%Shop').hide()


func _on_Storage_pressed():
	pass # Replace with function body.
