extends Panel

var item_id_ref
var items_available_ids = []


func _ready():
	ManagerGame.connect("item_bought", self, 'on_item_bought')
	
#	for child in get_node('%ShopList').get_children():
#		child.connect('clicked', self, 'on_shop_list_clicked')
	
	for child in get_node('%ShopList').get_children():
		items_available_ids.append(child.item_id)
	
	get_node('%Gold').text = str(ManagerGame.player_data['money'])


# this function is called when selecting an individual item on the shop list
## see ShopDisplay.tscn
#func on_shop_list_clicked(item_id: String):
#	item_id_ref = item_id
#
#	var price = ManagerGame.all_items.get(item_id).get('price')
#
#	get_node('%ConfirmControl').get_node("ConfirmPanel/VBoxContainer/BuyConfirm").text = 'Buy %s' % str(price)
#
#	get_node('%ConfirmControl').show()


func on_item_bought(item_id):
	get_node('%Gold').text = str(ManagerGame.player_data['money'])


func _on_ConfirmControl_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		get_node('%ConfirmControl').hide()


func _on_BuyConfirm_pressed():
	
	# copies the array of item ids
	# then shuffles the indexes (act as a randomizer)
	var temp = items_available_ids.duplicate()
	temp.shuffle()
	
	ManagerGame.buy_item(temp[0])
	hide()
	get_node('%ConfirmControl').hide()


#func _on_BuyConfirm_pressed():
#	ManagerGame.buy_item(item_id_ref)
#	hide()
#	get_node('%ConfirmControl').hide()


func _on_CloseShop_pressed():
	hide()


func _on_Gold_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		get_node('%CoinsBuyPopup').popup()


func _on_Gift_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		var price = 10
		get_node('%ConfirmControl').get_node("ConfirmPanel/VBoxContainer/BuyConfirm").text = 'Buy %s' % str(price)
		get_node('%ConfirmControl').show()
