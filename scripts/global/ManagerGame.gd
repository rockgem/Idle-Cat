extends Node


signal item_bought


func buy_item(item_id: String):
	
	
	emit_signal("item_bought", item_id)
