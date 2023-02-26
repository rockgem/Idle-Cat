extends Node


signal item_bought(item_id)


var all_items: Dictionary = {}


var player_data: Dictionary = {
	'money': 100
}



func _ready():
	var f = File.new()
	f.open("res://resources/data/all_items.json", f.READ)
	all_items = parse_json(f.get_as_text())
	f.close()


func buy_item(item_id: String):
	if all_items.has(item_id) == false:
		return
	
	
	
	emit_signal("item_bought", item_id)
