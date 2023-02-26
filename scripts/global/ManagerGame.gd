extends Node


signal item_bought


var all_items: Dictionary = {}


var player_data: Dictionary = {
	'money': 100
}



func _ready():
	pass


func buy_item(item_id: String):
	
	
	emit_signal("item_bought", item_id)
