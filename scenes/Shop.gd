extends Panel

var item_id_ref


func _ready():
	for child in get_node('%ShopList').get_children():
		child.connect('clicked', self, 'on_shop_list_clicked')


func on_shop_list_clicked(item_id: String):
	item_id_ref = item_id
	
	var price = ManagerGame.all_items.get(item_id).get('price')
	
	get_node('%ConfirmControl').get_node("ConfirmPanel/VBoxContainer/BuyConfirm").text = 'Buy %s' % str(price)
	
	get_node('%ConfirmControl').show()


func _on_ConfirmControl_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		get_node('%ConfirmControl').hide()


func _on_BuyConfirm_pressed():
	ManagerGame.buy_item(item_id_ref)
	hide()
	get_node('%ConfirmControl').hide()


func _on_CloseShop_pressed():
	hide()
